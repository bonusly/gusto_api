RSpec.describe GustoApi::OauthRequest do
  before do
    GustoApi.configure do |config|
      config.api_token = 'token'
      config.client_id = 'client id'
      config.client_secret = 'client secret'
      config.redirect_url = 'redirect url'
      config.testing = true
    end
  end

  let(:subject) { described_class.new(method: :get) }

  describe '#initialize' do
    it 'sets endpoint to oauth/token' do
      expect(subject.send(:endpoint)).to eq 'oauth/token'
    end

    it 'sets auth_token to nil' do
      expect(subject.send(:auth_token)).to be nil
    end

    it 'sets auth_type to nil' do
      expect(subject.send(:auth_type)).to be nil
    end
  end
end
