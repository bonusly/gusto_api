RSpec.describe GustoApi::Configuration do
  subject { described_class.new }

  %i[api_token client_id client_secret redirect_url testing].each do |configurable_attr|
    specify { expect(subject).to respond_to(configurable_attr) }
    specify { expect(subject).to respond_to(:"#{configurable_attr}=") }
  end

  describe '#base_uri' do
    it 'returns demo uri when testing' do
      subject.testing = true
      expect(subject.base_uri).to eq 'https://api.gusto-demo.com/v1/'
    end

    it 'returns production uri when testing' do
      subject.testing = false
      expect(subject.base_uri).to eq 'https://api.gusto.com/v1/'
    end
  end
end
