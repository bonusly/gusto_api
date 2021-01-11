require 'httparty'

module GustoApi
  class Request
    def initialize(endpoint:, method:, params: {}, auth_token: GustoApi.configuration.api_token)
      raise Error.new("Invalid method: #{method}. Must be :get or :post") unless %i[get post].include?(method)

      self.endpoint = endpoint
      self.method = method
      self.params = params
      self.auth_token = auth_token
    end

    def submit
      HTTParty.send(method, url, options)
    end

    private

    attr_accessor :endpoint, :method, :params, :auth_token

    def options
      {
        headers: headers
      }.merge(param_options)
    end

    def headers
      {
        "Authorization" => "Token #{auth_token}"
      }
    end

    def param_options
      return {} unless params.any?

      {
        params_key => params
      }
    end

    def url
      URI.join(GustoApi.configuration.base_uri, endpoint).to_s
    end

    def params_key
      method == :get ? :query : :body
    end
  end
end
