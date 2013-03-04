#require 'active_support'

module Kahana
  module Architecture
    extend ActiveSupport::Concern

    # Include ActiveModel & Kahana modules here
    include Kahana::Error
    include Kahana::Connection
    include Kahana::Request

    # Specify Modules here with methods specific to Kahana
    MODULES = []

    class << self

      # Get a list of methods Kahana method names that need to be
      # overwritten with care when including Kahana::Service
      #
      def prohibited_methods
        @prohibited_methods ||= MODULES.flat_map do |mod|
          mod.instance_methods.map{ |m| m.to_sym }
        end
      end

    end

  end
end

