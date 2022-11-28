# frozen_string_literal: true

require 'action_controller/railtie'

module OhdearHealthCheck
  class HealthChecksController < ActionController::Base
    def check
      OhdearHealthCheck::Checker.new.check
      render json: OhdearHealthCheck::Response.new.call
    end
  end
end
