# frozen_string_literal: true

module OhdearHealthCheck
  class Check
    attr_accessor :name, :block, :error_message, :success_message, :result

    class Error < StandardError; end

    def initialize(name, block, success_message = nil, error_message = nil)
      raise Error, 'You must pass a block' if block.nil? || !block.is_a?(Proc)

      @name = name
      @block = block
      @error_message = error_message
      @success_message = success_message
      @result = nil
    end

    def execute!
      block.call
    end
  end
end
