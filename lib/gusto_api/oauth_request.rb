module GustoApi
  class OauthRequest < Request
    def initialize(method:, params: {})
      super(
        endpoint: 'oauth/token',
        method: method,
        params: params,
        auth_token: nil,
        auth_type: nil
      )
    end
  end
end
