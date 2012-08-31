require 'ganglia/gearman/version'
require 'ganglia/gearman/gearman_server'
require 'ganglia/gearman/ganglia_connection'

module Ganglia
  class Gearman
    def initialize(options = {})
      @gearman_host = options[:gearman_host] || '127.0.0.1'
      @gearman_port = options[:gearman_port] || 4730

      @gmond_host = options[:gmond_host] || '127.0.0.1'
      @gmond_port = options[:gmond_port] || 8649
    end

    def report

      GangliaConnection.new(@gmond_host, @gmond_port).report(status)
    end

    private

    def status
      @status ||= GearmanServer.new(@gearman_host, @gearman_port).status
    end
  end
end
