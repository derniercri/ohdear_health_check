# frozen_string_literal: true

module OhdearHealthCheck
  class Router
    def self.mount(router)
      router.send(
        :get,
        '/health_check' => 'ohdear_health_check/health_checks#check',
      )
    end
  end
end
