RSpec.describe GustoApi::TokenRequest do
  before do
    GustoApi.configure do |config|
      config.api_token = 'token'
      config.client_id = 'client id'
      config.client_secret = 'client secret'
      config.redirect_url = 'redirect url'
      config.testing = true
    end
  end

  let(:subject) { described_class.new(endpoint: 'v1/test', method: :get) }

  describe '#initialize' do
    it 'sets auth_token to GustoApi.configuration.api_token' do
      expect(subject.send(:auth_token)).to eq 'token'
    end

    it 'sets auth_type to Token' do
      expect(subject.send(:auth_type)).to eq 'Token'
    end
  end
end
