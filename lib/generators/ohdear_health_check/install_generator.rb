# frozen_string_literal: true

require 'rails/generators/base'

module OhdearHealthCheck
  class InstallGenerator < Rails::Generators::Base
    desc 'It creates an initializer to set the health check settings and add the route'
    source_root File.expand_path('templates', __dir__) # This line added

    def copy_initializer_file
      template 'ohdear_health_check.rb', 'config/initializers/ohdear_health_check.rb'
    end

    def add_route
      route 'OhdearHealthCheck.routes(self)'
    end
  end
end
