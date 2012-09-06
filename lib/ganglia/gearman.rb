require 'ganglia/gearman/version'
require 'ganglia/gearman/gearman_server'
require 'ganglia/gearman/ganglia_connection'

module Ganglia
  class Gearman
    def initialize(options = {})
      @gearman_host = options[:gearman_host] || '127.0.0.1'
      @gearman_port = options[:gearman_port] || 4730

      @gmond_host = options[:ganglia_host] || '127.0.0.1'
      @gmond_port = options[:ganglia_port] || 8649
      @gmond_spoof = options[:spoof]

      @interval = options[:inteval] || 1
    end

    def run
      gearman.run(lambda {|status| ganglia.report(status) }, @interval)
    end

    private

    def gearman
      @gearman ||= GearmanServer.new(@gearman_host, @gearman_port)
    end

    def ganglia
      @ganglia ||= GangliaConnection.new(@gmond_host, @gmond_port)
    end
  end
end
