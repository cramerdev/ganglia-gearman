require 'gmetric'

module Ganglia
  class Gearman
    class GangliaConnection
      def initialize(host = '127.0.0.1', port = 8649)
        @host = host
        @port = port
      end

      def report(functions)
        functions.each do |function|
          self.class.metrics_for(function).each do |metric|
            p metric
            Ganglia::GMetric.send(metric)
          end
        end
      end

      def self.metrics_for(function)
        [:total, :running, :available].map do |metric|
          self.class.to_gmetric({ :function => function[:function],
                                  :metric   => metric,
                                  :value    => function[:value] })
        end
      end

      def self.to_gmetric(metric)
        {
          :name  => "#{metric[:function] }_#{metric[:metric]}",
          :type  => 'uint32',
          :value => metric[:value],
          :tmax  => 60,
          :dmax  => 300,
          :group => 'gearman'
        }
      end
    end
  end
end
