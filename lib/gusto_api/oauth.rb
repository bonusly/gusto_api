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

    def self.get_token(code)
      OauthRequest.new(
        method: :post,
        params: {
          client_id: GustoApi.configuration.client_id,
          client_secret: GustoApi.configuration.client_secret,
          redirect_uri: GustoApi.configuration.redirect_url,
          code: code,
          grant_type: 'authorization_code'
        }
      ).submit
    end

    def self.refresh_token(refresh_token)
      OauthRequest.new(
        method: :post,
        params: {
          client_id: GustoApi.configuration.client_id,
          client_secret: GustoApi.configuration.client_secret,
          redirect_uri: GustoApi.configuration.redirect_url,
          refresh_token: refresh_token,
          grant_type: 'refresh_token'
        }
      ).submit
    end
  end
end
