#require 'faraday/response/raise_http_error'
#require 'faraday/request/url_encoding_fix'
#require 'faraday/response/raise_http_4xx'
#require 'faraday/response/raise_http_5xx'

module Kahana
  # @private
  module Connection
    private

    # Public: Initializes a new Faraday::Connection.
    #
    # url     - The optional String base URL to use as a prefix for all
    #           requests.  Can also be the options Hash.
    # options - The optional Hash used to configure this Faraday::Connection.
    #           Any of these values will be set on every request made, unless
    #           overridden for a specific request.
    #           :url     - String base URL.
    #           :params  - Hash of URI query unencoded key/value pairs.
    #           :headers - Hash of unencoded HTTP header key/value pairs.
    #           :request - Hash of request options.
    #           :ssl     - Hash of SSL options.
    #           :proxy   - Hash of Proxy options.
    #           :parallel_manager

    def default_headers
      _hide_user_agent ? nil : { 'User-Agent' => user_agent }
    end

    def default_options
      {
        :proxy    => _proxy || proxy,
        :headers  => _headers || default_headers,
        :request  => _request,
        :ssl      => _ssl,
        :url      => _url_prefix
      }
    end

    # Warning: With the exception of params, connection level options
    # overwrite default options, including the user agent
    def connection_options(request_options = {})
      options = default_options
      options[:proxy] = request_options[:proxy] if request_options[:proxy]
      options[:headers] = request_options[:headers] if request_options[:headers]
      options[:request] = request_options[:request] if request_options[:request]
      options[:ssl] = request_options[:ssl] if request_options[:ssl]
      options[:url] = request_options[:url] if request_options[:url]
      options[:parallel_manager] = request_options[:parallel_manager]
      options.delete_if{ |k,v| v.nil? || v.empty? }
    end

    def connection(*args)
      options = args.last.is_a?(Hash) ? args.last : {}
      #raw = options[:raw] || false
      #format = option[:format] || _format

      # TODO:
      # Create method
      # Proc that takes middleware and returns middleware
      default_middleware = Proc.new do |middleware|
        Proc.new do |m|
          handlers = middleware.call(m)
          unless handlers.any? {|h| h.name =~ %r{#{Faraday::Adapter.to_s}}  }
            m.adapter :em_http
          end
        end
      end
#
#      Faraday::Connection.new(connection_options(options), default_middleware.call(&_middleware))
      #binding.pry
      Faraday::Connection.new(connection_options(options), &default_middleware.call(_middleware))
#      Faraday::Connection.new(connection_options(options)) do |connection|
#        #connection.use Faraday::Request::OAuth2, client_id, access_token
#        #connection.use Faraday::Request::UrlEncodingFix
#        #connection.use Faraday::Response::RaiseHttp4xx
#        #connection.use Faraday::Response::Mashify unless raw
#        #unless raw
#        #  case format.to_s.downcase
#        #  when 'json'
#        #    connection.use Faraday::Response::ParseJson
#        #  end
#        #end
#        # POST/PUT params encoders:
#        # Check for files in the payload, otherwise leave everything untouched
#        # Faraday::Request::Multipart
#        # connection.request :multipart
#        connection.use Faraday::Request::Multipart
#        # Encodes as "application/x-www-form-urlencoded" if not already encoded or of another type
#        # connection.request :url_encoded
#        connection.use Faraday::Request::UrlEncoded
#        #connection.use Faraday::Response::RaiseHttp5xx
#        # ADAPTER:
#        # The adapter should be last, as later middlewares
#        # wrap all previous middlewares
#        connection.adapter(adapter)
#      end
    end

  end
end
