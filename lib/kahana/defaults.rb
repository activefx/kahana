require 'faraday'
require 'kahana/configuration'

module Kahana
  module Defaults

    class << self

      def options
        Hash[Kahana.available_options.map{ |key| [key, default_value(key)] }]
      end

      def http_adapter
        Faraday.default_adapter
      end

      private

      def default_value(key)
        begin
          send(key)
        rescue NoMethodError
          nil
        end
      end

    end

  end
end

