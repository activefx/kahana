require "kahana/version"
require "kahana/configuration"

module Kahana
  extend Configuration

  def client
    Service.new(options)
  end

  def respond_to?(method, include_private=false)
    self.client.respond_to?(method, include_private) || super
  end

  private

  def method_missing(method, *args, &block)
    return super unless self.client.respond_to?(method)
    self.client.send(method, *args, &block)
  end

end

