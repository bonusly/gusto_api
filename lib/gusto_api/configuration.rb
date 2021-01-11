module GustoApi
  class Configuration
    attr_accessor :api_token, :client_id, :client_secret, :redirect_url, :testing

    def initialize
      self.testing = true
    end

    def base_uri
      testing ? 'https://api.gusto-demo.com/v1/' : 'https://api.gusto.com/v1/'
    end
  end
end
