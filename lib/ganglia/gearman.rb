require "ganglia/gearman/version"

module Ganglia
  class Gearman
    def initialize(options = {})
      @gearman_host = options[:gearman_host] || '127.0.0.1'
      @gearman_port = options[:gearman_port] || 4730

      @gmond_host = options[:gmond_host] || '127.0.0.1'
      @gmond_port = options[:gmond_port] || 8649
    end

    def send
    end
  end
end
