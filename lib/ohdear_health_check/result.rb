# frozen_string_literal: true

module OhdearHealthCheck
  class Result
    attr_accessor :name, :exception, :message, :status, :response_time

    def initialize(status, name, message, exception = nil, response_time = nil)
      @status = status
      @name = name
      @message = message&.squish
      @exception = exception.to_s
      @response_time = response_time&.round(3)
    end
  end
end
