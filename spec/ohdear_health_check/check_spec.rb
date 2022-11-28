# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OhdearHealthCheck::Check, type: :model do
  let(:name) { :passing_check }
  let(:block) { -> { 'passed' } }
  let(:success_message) { 'Check passed' }
  let(:error_message) { 'Check failed' }

  subject { described_class.new(name, block, success_message, error_message) }

  it { is_expected.to be_a(described_class) }
  it { expect(subject.name).to eq(name) }
  it { expect(subject.block).to eq(block) }
  it { expect(subject.success_message).to eq(success_message) }
  it { expect(subject.error_message).to eq(error_message) }
  it { expect(subject.result).to eq(nil) }
  it { expect(subject.execute!).to eq('passed') }

  context 'with no block is given' do
    subject { described_class.new(name, nil, success_message, error_message) }
    it { expect { subject }.to raise_error(OhdearHealthCheck::Check::Error).with_message('You must pass a block') }
  end
end
