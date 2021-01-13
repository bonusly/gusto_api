module GustoApi
  class BearerRequest < Request
    def initialize(endpoint:, method:, params: {}, auth_token:)
      super(endpoint: endpoint, method: method, params: params, auth_token: auth_token, auth_type: 'Bearer')
    end
  end
end
