module GustoApi
  class CurrentUser
    def self.fetch(access_token)
      GustoApi::BearerRequest.new(
        endpoint: 'v1/me',
        method: :get,
        auth_token: access_token
      ).submit
    end
  end
end
