module GustoApi
  class Oauth
    def self.auth_url
      [
        GustoApi.configuration.base_uri,
        "oauth/authorize",
        "?client_id=#{GustoApi.configuration.client_id}",
        "&redirect_uri=#{GustoApi.configuration.redirect_url}",
        "&response_type=code"
      ].join
    end
  end
end
