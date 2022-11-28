# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OhdearHealthCheck::Result, type: :model do
  subject { described_class.new(:ok, :database, 'Database is up', nil, Time.now.to_i) }

  it { is_expected.to be_a(described_class) }

  describe '#initialize' do
    context 'with wrong status' do
      subject { described_class.new(:success, :database, 'Database is up', nil, Time.now.to_i) }

      it {
        expect do
          subject
        end.to raise_error(OhdearHealthCheck::Result::Error).with_message('Status must be one of [ok, failed]')
      }
    end

    context 'with wrong name' do
      subject { described_class.new(:ok, :wrong_name, 'Database is up', nil, Time.now.to_i) }

      it do
        expect do
          subject
        end.to raise_error(OhdearHealthCheck::Result::Error).with_message('Name must be one of [database, migrations]')
      end
    end
  end
end
