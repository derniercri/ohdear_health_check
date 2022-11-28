# frozen_string_literal: true

RSpec.describe OhdearHealthCheck::HealthChecksController, type: :model do
  describe '#check' do
    let(:controller) { described_class.new }

    subject { controller.check }

    before do
      Timecop.freeze(Time.parse('2022-11-25 16:00 UTC'))
      OhdearHealthCheck.configuration.send(:clear!)
      OhdearHealthCheck.configure do |config|
        config.add_check :zero_division, -> { 100 / 0 }
      end
    end

    after do
      subject
      Timecop.unfreeze
    end

    context 'when check with success' do
      before { allow_any_instance_of(OhdearHealthCheck::Check).to receive(:execute!) }

      it 'returns verbose response' do
        expect(controller)
          .to receive(:render)
          .with(
            {
              json: {
                checkResults: [
                  {
                    label:               :Zero_division,
                    meta:                {
                      health:       :ok,
                      responseTime: '0.0s',
                    },
                    name:                :zero_division,
                    notificationMessage: nil,
                    shortSummary:        nil,
                    status:              :ok,
                  },
                ],
                finishedAt:   1_669_392_000,
              },
            },
          )
          .once
      end
    end

    context 'when check without success' do
      it 'returns verbose response' do
        expect(controller)
          .to receive(:render)
          .with(
            {
              json: {
                checkResults: [
                  {
                    label:               :Zero_division,
                    meta:                {
                      errorClass:   'ZeroDivisionError',
                      errorMessage: 'divided by 0',
                    },
                    name:                :zero_division,
                    notificationMessage: 'divided by 0',
                    shortSummary:        'divided by 0',
                    status:              :failed,
                  },
                ],
                finishedAt:   1_669_392_000,
              },
            },
          )
          .once
      end
    end
  end
end
