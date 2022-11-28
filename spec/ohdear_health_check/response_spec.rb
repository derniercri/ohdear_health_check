# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OhdearHealthCheck::Response, type: :model do
  subject { described_class.new }

  it { is_expected.to be_a(described_class) }

  describe '#call' do
    before do
      OhdearHealthCheck.configuration.send(:clear!)
      OhdearHealthCheck.configure do |config|
        config.add_check :zero_division, -> { 100 / 0 }, nil, "You can't divide by 0"
        config.add_check :passing_check, -> { raise StandardError }
        config.add_check :passing_check, -> { 1 + 1 }, 'Check passed'
      end
      OhdearHealthCheck::Checker.new.check
      allow_any_instance_of(described_class).to receive(:success_meta).and_return(
        {
          health:       :ok,
          responseTime: '0.300s',
        },
      )
    end

    it 'returns a formatted hash to send to OhDear' do
      expect(Timecop.freeze(Time.parse('2022-11-25 16:00 UTC')) { subject.call }).to eq(
        {
          finishedAt:   1_669_392_000,
          checkResults: [
            {
              name:                :zero_division,
              label:               :Zero_division,
              status:              :failed,
              notificationMessage: "You can't divide by 0",
              shortSummary:        "You can't divide by 0",
              meta:                {
                errorClass:   'ZeroDivisionError',
                errorMessage: "You can't divide by 0",
              },
            },
            {
              name:                :passing_check,
              label:               :Passing_check,
              status:              :failed,
              notificationMessage: 'StandardError',
              shortSummary:        'StandardError',
              meta:                {
                errorClass:   'StandardError',
                errorMessage: 'StandardError',
              },
            },
            {
              name:                :passing_check,
              label:               :Passing_check,
              status:              :ok,
              notificationMessage: 'Check passed',
              shortSummary:        'Check passed',
              meta:                {
                health:       :ok,
                responseTime: '0.300s',
              },
            },
          ],
        },
      )
    end
  end
end
