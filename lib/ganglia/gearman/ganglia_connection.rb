require 'gmetric'

module Ganglia
  class Gearman
    class GangliaConnection
      def initialize(host = '127.0.0.1', port = 8649, spoof = false)
        @host = host
        @port = port
        @spoof = spoof
      end

      def report(functions)
        functions.each do |function|
          self.class.metrics_for(function).each do |metric|
            begin
              Ganglia::GMetric.send(@host, @port, metric)
            rescue Errno::ECONNREFUSED, SocketError => e
              STDERR.puts("Connection to #{@host}:#{@port} refused")
            end
          end
        end
      end

      def self.metrics_for(function)
        [:total, :running, :available].map do |metric|
          to_gmetric({ :function => function[:function],
                                  :metric   => metric,
                                  :value    => function[metric] })
        end
      end

      def self.to_gmetric(metric)
        m = {
          :name  => "#{metric[:function] }_#{metric[:metric]}",
          :type  => 'uint32',
          :value => metric[:value],
          :tmax  => 60,
          :dmax  => 300,
          :group => 'gearman'
        }
        m.merge!({ :spoof => true, :hostname => @spoof }) if @spoof
        m
      end
    end
  end
end
