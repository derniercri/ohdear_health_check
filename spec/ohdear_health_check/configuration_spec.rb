# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OhdearHealthCheck::Configuration, type: :model do
  describe '#initialize' do
    subject { described_class.new }

    it { is_expected.to be_a(described_class) }

    context 'with mandatory default checks' do
      it { expect(subject.checks.length).to eq(2) }
      it { expect(subject.checks.map(&:name).sort).to eq(%i[database migrations]) }
    end

    context 'with optional library default checks' do
      before do
        described_class::DETECTABLE_CHECKS.each { |class_name| Object.const_set(class_name, Class.new) }
      end

      after do
        described_class::DETECTABLE_CHECKS.each { |class_name| Object.send(:remove_const, class_name) }
      end

      it { expect(subject.checks.length).to eq(4) }
      it { expect(subject.checks.map(&:name).sort).to eq(%i[database migrations redis sidekiq]) }
    end
  end

  describe '#add_check' do
    let(:name) { :zero_division }
    let(:block) { -> { 100 / 0 } }
    let(:instance) { described_class.new }

    subject { instance.add_check(name, block) }

    before { subject }

    it { expect(instance.checks).not_to be_empty }
    it { expect(instance.checks.length).to eq(3) }
    it { expect(instance.checks.last).to be_a(OhdearHealthCheck::Check) }
    it { expect(instance.checks.map(&:name).sort).to eq(%i[database migrations zero_division]) }
  end

  describe '#check_names' do
    it { expect(subject.check_names).to eq(%i[database migrations]) }
  end
end
