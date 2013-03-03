require "kahana/configuration"

module Kahana
  class Client

    def initialize(options = {})
      Kahana.available_options.each do |key|
        instance_variable_set("@#{key}", options[key] || Kahana.options[key])
      end
    end

  end
end

