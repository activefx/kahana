module Kahana
  # Defines HTTP request methods
  module Request
    extend ActiveSupport::Concern

    # Perform an HTTP GET request
    def get(path, options = {})
      request(:get, path, options)
    end

    # Perform an HTTP POST request
    def post(path, options = {})
      request(:post, path, options)
    end

    # Perform an HTTP PUT request
    def put(path, options = {})
      request(:put, path, options)
    end

    # Perform an HTTP DELETE request
    def delete(path, options = {})
      request(:delete, path, options)
    end

    private

    # Perform an HTTP request
    def request(method, path, options)
      conn = connection(options)
      conn.instance_variable_set(:@parallel_manager, options[:parallel_manager]) if options[:parallel_manager]
      #binding.pry
      response = conn.send(method) do |request|
        #path = formatted_path(path) unless options[:unformatted] # || default_request?
        params = get_params(options)
        case method
        when :get, :delete
          request.url(path, params)
          # binding.pry
        when :post, :put
          request.path = path
          #if options['fileData']
          #  request.headers['Content-type'] = 'multipart/form-data'
          #  request.body = options
          #else
            #request.headers['Content-Type'] = 'application/json; charset=utf-8'
          request.body = params unless params.empty?
          #end
        end
        if options[:parallel_manager]
          env = request.to_env(conn)
          conn.parallel_manager.responses[env[:url].to_s] = {}
          conn.parallel_manager.responses[env[:url].to_s]['env'] = env
        end
      end
      #
      #binding.pry
      options[:raw] ? response : response.body
      #binding.pry
    end

    def formatted_path(path)
      [path, format].compact.join('.')
    end

    def get_params(options = {})
      _params.merge!(options).delete_if{ |k,v| _connection_options.include?(k) }
    end

    #def default_request?
    #  format.to_sym == :json
    #end

  end
end
