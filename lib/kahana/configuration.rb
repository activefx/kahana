require 'faraday'
require 'kahana/defaults'

module Kahana
  module Configuration

    OPTIONS = [
      :http_adapter
    ]

    attr_accessor *OPTIONS

    # Allow configuration via block
    #
    def configure
      yield self if block_given?
      self
    end

    def available_options
      @available_options ||= OPTIONS
    end

    def defaults
      @defaults ||= Defaults.options
    end

    def settings
      available_options.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    def options
      defaults.merge!(settings)
    end

    def reset!
      available_options.each do |key|
        instance_variable_set("@#{key}", Kahana::Defaults.options[key])
      end
      self
    end

  end
end

