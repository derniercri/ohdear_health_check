# frozen_string_literal: true

RSpec.describe OhdearHealthCheck, type: :module do
  it { expect(described_class::VERSION).not_to be nil }

  describe '.configure' do
    let(:name) { :zero_division }
    let(:block) { -> { 100 / 0 } }

    before do
      described_class.configure do |config|
        config.add_check(name, block)
      end
    end

    it { expect(described_class.configuration.checks.size).to eq(3) }
    it { expect(described_class.configuration.checks.first).to be_a(OhdearHealthCheck::Check) }
  end

  describe '.configuration' do
    subject { described_class.configuration }

    it { is_expected.to be_a(described_class::Configuration) }
  end

  describe '.routes' do
    subject { described_class.routes(nil) }

    after { subject }

    it { expect(OhdearHealthCheck::Router).to receive(:mount).once }
  end
end
