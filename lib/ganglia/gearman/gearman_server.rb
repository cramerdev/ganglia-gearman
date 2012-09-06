require 'socket'

module Ganglia
  class Gearman
    class GearmanServer
      def initialize(host = '127.0.0.1', port = 4730)
        @host = host
        @port = port
      end

      def status
        results = []
        begin
          TCPSocket.open(@host, @port) do |s|
            s.puts 'status'
            while line = s.gets.chomp
              break if line == "."
              (function, total, running, available) = line.split(/\t/)
              results << { :function  => function,
                           :total     => total.to_i,
                           :running   => running.to_i,
                           :available => available.to_i }
            end
          end
        rescue Errno::ECONNREFUSED, SocketError => e
          STDERR.puts("Connection to #{@host}:#{@port} refused")
        end
        results
      end

      def run(callback, interval = 1)
        loop do
          callback.call(status)
          sleep interval
        end
      end
    end
  end
end
