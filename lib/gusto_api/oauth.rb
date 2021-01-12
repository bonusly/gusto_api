module GustoApi
  class Oauth
    def self.auth_url
      URI(GustoApi.configuration.base_uri + "oauth/authorize").tap do |uri|
        uri.query = URI.encode_www_form(
          client_id: GustoApi.configuration.client_id,
          redirect_uri: GustoApi.configuration.redirect_url,
          response_type: 'code'
        )
      end.to_s
    end
  end
end
