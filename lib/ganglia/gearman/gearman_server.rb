require 'socket'

module Ganglia
  class Gearman
    class GearmanServer
      def initialize(host = '127.0.0.1', port = 4730)
        @host = host
        @port = port
      end

      def status
        s = socket
        results = []
        s.puts 'status'
        while line = s.gets.chomp
          break if line == "."
          (function, total, running, available) = line.split(/\t/)
          results << { :function  => function,
                       :total     => total.to_i,
                       :running   => running.to_i,
                       :available => available.to_i }
        end
        results
      ensure
        s.close
      end

      private

      def socket
        @socket ||= TCPSocket.new(@host, @port)
      end
    end
  end
end
