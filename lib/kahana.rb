require "active_support/core_ext"
require "faraday_middleware"
require "kahana/version"
require "kahana/configuration"
require "kahana/client"
require "kahana/error"
require "kahana/connection"
require "kahana/request"
require "kahana/architecture"
require "kahana/service"


module Kahana
  extend Configuration
  #extend self
#  class << self
#    include Configuration

#    def client
#      Client.new #true #new(options)
#    end

#    def respond_to?(method, include_private=false)
#      self.client.respond_to?(method, include_private) || super
#    end

#    private

#    def method_missing(method, *args, &block)
#      return super unless self.client.respond_to?(method)
#      self.client.send(method, *args, &block)
#    end

#  end
end

