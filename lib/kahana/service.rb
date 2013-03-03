module Kahana
  module Service
    extend ActiveSupport::Concern
    # include Kahana::Architecture

    included do

      class_attribute :_http_adapter
      class_attribute :_headers
      class_attribute :_format
      class_attribute :_params
      class_attribute :_url_prefix
      class_attribute :_request
      class_attribute :_proxy
      class_attribute :_ssl
      class_attribute :_hide_user_agent
      class_attribute :_middleware
      class_attribute :_connection_options

      self._http_adapter = nil
      self._headers = {}
      self._format = nil
      self._params = {}
      self._url_prefix = nil
      self._request = {}
      self._proxy = {}
      self._ssl = {}
      self._hide_user_agent = false
      self._middleware = Proc.new{|b|}
      self._connection_options = [
        :proxy, :headers, :request, :ssl, :url,
        :parallel_manager, :raw, :unformatted
      ]

      attr_accessor *Kahana.available_options
      #attr_accessor :configured_options

    end



    # Creates a new API
    def initialize(options = {})
      application_configuration.merge!(options)
      configuration_options.each do |key|
        send("#{key}=", application_configuration[key])
      end
    end

    def application_configuration
      @configured_options ||= Kahana.options
    end

    def configuration_options
      Kahana.available_options
    end

    #def configured_options=()

    #end

    module ClassMethods

      def client(options = {})
        new(options)
      end

      # def http_adapter(adapter_name = nil)
      #   if adapter_name
      #     self._http_adapter = adapter_name
      #   else
      #     self._http_adapter
      #   end
      # end
      # alias :adapter :http_adapter

      def header(hash)
        self._headers.merge!(hash)
      end
      alias :headers :header

      def format(format)
        self._format = format
      end

      def param(hash)
        self._params.merge!(hash)
      end
      alias :params :param

      def url_prefix(url)
        self._url_prefix = url
      end
      alias :endpoint :url_prefix

      def request(hash)
        self._request.merge!(hash)
      end

      def ssl(hash)
        self._ssl.merge!(hash)
      end

      def proxy(arg)
        if arg.is_a?(Hash)
          self._proxy.merge!(hash)
        else
          self._proxy[:uri] = arg
        end
      end

      def hide_user_agent
        self._hide_user_agent = true
      end

      # TODO
      #   Add em_http last
      #   Raise error if adapter called
      def middleware(&block)
        if block_given?
          self._middleware = block
        end
      end

      # def method_missing(method, *args, &block)
      #   return super unless client.respond_to?(method)
      #   client.send(method, *args, &block)
      # end

      # def respond_to?(method)
      #   return client.respond_to?(method) || super
      # end

      def respond_to?(method, include_private=false)
        self.client.respond_to?(method, include_private) || super
      end

      private

      def method_missing(method, *args, &block)
        return super unless self.client.respond_to?(method)
        self.client.send(method, *args, &block)
      end

    end

  end
end

