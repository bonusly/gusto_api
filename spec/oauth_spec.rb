RSpec.describe GustoApi::Oauth do
  before do
    GustoApi.configure do |config|
      config.api_token = 'token'
      config.client_id = 'clientid'
      config.client_secret = 'secret'
      config.redirect_url = 'http://www.example.com/callback'
      config.testing = false
    end
  end

  describe '.auth_url' do
    it 'returns the URL for kicking off oauth with gusto' do
      expect(described_class.auth_url).to eq 'https://api.gusto.com/oauth/authorize?client_id=clientid&redirect_uri=http%3A%2F%2Fwww.example.com%2Fcallback&response_type=code'
    end
  end
end
