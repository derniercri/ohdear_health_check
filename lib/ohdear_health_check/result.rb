# frozen_string_literal: true

module OhdearHealthCheck
  class Result
    attr_accessor :name, :exception, :message, :status, :response_time

    STATUSES = %i[ok failed].freeze

    class Error < StandardError; end

    def initialize(status, name, message, exception = nil, response_time = nil)
      raise Error, "Status must be one of [#{STATUSES.join(', ')}]" unless STATUSES.include?(status.to_sym)
      raise Error, "Name must be one of [#{check_names.join(', ')}]" unless check_names.include?(name.to_sym)

      @status = status.to_sym
      @name = name.to_sym
      @message = message&.squish
      @exception = exception.to_s
      @response_time = response_time&.round(3)
    end

    private

    def check_names
      OhdearHealthCheck.configuration.check_names
    end
  end
end
