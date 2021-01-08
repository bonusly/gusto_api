RSpec.describe GustoApi do
  it "has a version number" do
    expect(GustoApi::VERSION).not_to be nil
  end

  describe '.configure' do
    it 'sets attributes on GustoApi.configuration' do
      described_class.configure do |config|
        config.api_token = 'token'
        config.client_id = 'client id'
        config.client_secret = 'client secret'
        config.redirect_url = 'redirect url'
        config.testing = false
      end

      expect(GustoApi.configuration.api_token).to eq 'token'
      expect(GustoApi.configuration.client_id).to eq 'client id'
      expect(GustoApi.configuration.client_secret).to eq 'client secret'
      expect(GustoApi.configuration.redirect_url).to eq 'redirect url'
      expect(GustoApi.configuration.testing).to be false
    end
  end
end
