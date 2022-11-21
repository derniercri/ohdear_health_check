# frozen_string_literal: true

module OhdearHealthCheck
  class Checker
    def check
      OhdearHealthCheck.configuration
                       .checks
                       .map { |c| Thread.new { execute(c) } }
                       .each(&:join)
    end

    def errored?
      @errors.any?
    end

    private

    def execute(check)
      starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      check.execute!
      ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      elapsed = ending - starting
      check.result = Result.new(:ok, check.name, check.success_message, nil, elapsed)
    rescue StandardError => e
      check.result = Result.new(:failed, check.name, check.error_message || e.message, e.class, nil)
    end
  end
end
