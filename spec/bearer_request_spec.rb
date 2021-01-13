RSpec.describe GustoApi::BearerRequest do
  before do
    GustoApi.configure do |config|
      config.api_token = 'token'
      config.client_id = 'client id'
      config.client_secret = 'client secret'
      config.redirect_url = 'redirect url'
      config.testing = true
    end
  end

  let(:subject) { described_class.new(endpoint: 'v1/test', method: :get, auth_token: 'bearer token') }

  describe '#initialize' do
    it 'sets auth_token via argument' do
      expect(subject.send(:auth_token)).to eq 'bearer token'
    end

    it 'sets auth_type to Bearer' do
      expect(subject.send(:auth_type)).to eq 'Bearer'
    end
  end
end
