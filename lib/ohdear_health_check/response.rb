# frozen_string_literal: true

module OhdearHealthCheck
  class Response
    def call
      build_response
    end

    private

    def build_response
      {
        finishedAt:   Time.now.to_i,
        checkResults: OhdearHealthCheck.configuration.checks.map { |c| check_response(c) },
      }
    end

    def check_response(check)
      result = check.result
      {
        name:                check.name,
        label:               check.name.capitalize,
        status:              result.status,
        notificationMessage: result.message,
        shortSummary:        result.message,
        meta:                result.status == :ok ? success_meta(result) : error_meta(result),
      }
    end

    def success_meta(result)
      { health: :ok, responseTime: "#{result.response_time}s" }
    end

    def error_meta(result)
      { errorClass: result.exception, errorMessage: result.message }
    end
  end
end
