# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OhdearHealthCheck::Router, type: :model do
  describe '#mount' do
    let(:router) { double('Router') }

    subject { described_class.mount(router) }

    before do
      OhdearHealthCheck.configure do |config|
        config.add_check :zero_division, -> { 100 / 0 }, nil, "You can't divide by 0"
      end
    end

    after { subject }

    it do
      expect(router).to receive(:send).with(
        :get,
        '/health_check' => 'ohdear_health_check/health_checks#check',
      )
    end
  end
end
