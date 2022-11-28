# frozen_string_literal: true

require 'ohdear_health_check/version'
require 'ohdear_health_check/configuration'
require 'ohdear_health_check/check'
require 'ohdear_health_check/checker'
require 'ohdear_health_check/response'
require 'ohdear_health_check/result'
require 'ohdear_health_check/router'
require 'ohdear_health_check/engine'

module OhdearHealthCheck
  module_function

  def configure
    yield(configuration)
  end

  def configuration
    @configuration ||= Configuration.new
  end

  def check
    Checker.new.tap(&:check)
  end

  def routes(router)
    Router.mount(router)
  end
end
