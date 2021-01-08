RSpec.describe GustoApi::Configuration do
  subject { described_class.new }

  %i[api_token client_id client_secret redirect_url].each do |configurable_attr|
    specify { expect(subject).to respond_to(configurable_attr) }
    specify { expect(subject).to respond_to(:"#{configurable_attr}=") }
  end
end
