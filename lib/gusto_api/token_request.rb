module GustoApi
  class TokenRequest < Request
    def initialize(endpoint:, method:, params: {})
      super(endpoint: endpoint, method: method, params: params, auth_token: GustoApi.configuration.api_token, auth_type: 'Token')
    end
  end
end
