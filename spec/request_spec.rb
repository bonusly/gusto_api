RSpec.describe GustoApi::Request do
  before do
    GustoApi.configure do |config|
      config.api_token = 'token'
      config.client_id = 'client id'
      config.client_secret = 'client secret'
      config.redirect_url = 'redirect url'
      config.testing = true
    end
  end

  describe '#initialize' do
    it 'yells if passed an invalid method' do
      expect {
        described_class.new(endpoint: 'asdf', method: :teapot)
      }.to raise_error(GustoApi::Error, "Invalid method: teapot. Must be :get or :post")
    end

    it 'accepts :get' do
      expect {
        described_class.new(endpoint: 'asdf', method: :get)
      }.to_not raise_error
    end

    it 'accepts :post' do
      expect {
        described_class.new(endpoint: 'asdf', method: :post)
      }.to_not raise_error
    end
  end

  describe '#submit' do
    let(:params) { { bananas: true } }
    let(:subject) { described_class.new(endpoint: 'v1/test', method: method, params: params)}

    context 'when GET' do
      let(:method) { :get }

      it 'does reasonable httparty stuff' do
        expect(HTTParty).to receive(:get).with(
          'https://api.gusto-demo.com/v1/test', {
            headers: { "Authorization" => "Token token" },
            query: { bananas: true }
          }
        )
        subject.submit
      end
    end

    context 'when POST' do
      let(:method) { :post }

      it 'does reasonable httparty stuff' do
        expect(HTTParty).to receive(:post).with(
          'https://api.gusto-demo.com/v1/test', {
            body: { bananas: true },
            headers: { "Authorization" => "Token token" }
          }
        )
        subject.submit
      end
    end
  end
end
