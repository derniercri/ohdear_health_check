# frozen_string_literal: true

module OhdearHealthCheck
  class Checker
    def check
      OhdearHealthCheck.configuration
                       .checks
                       .map { |c| Thread.new { execute(c) } }
                       .each(&:join)
    end

    private

    def current_time
      Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end

    def execute(check)
      p check.name
      starting = current_time
      check.execute!
      ending = current_time
      elapsed = ending - starting
      check.result = Result.new(:ok, check.name, check.success_message, nil, elapsed)
    rescue StandardError => e
      check.result = Result.new(:failed, check.name, check.error_message || e.message, e.class, nil)
    end
  end
end
