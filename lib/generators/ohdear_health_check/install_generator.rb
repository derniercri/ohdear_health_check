# frozen_string_literal: true

require 'rails/generators/base'

module OhdearHealthCheck
  class InstallGenerator < Rails::Generators::Base
    desc 'It creates an initializer to set the health check settings'
    def create_initializer_file
      create_file(
        'config/initializers/ohdear_health_check.rb',
        <<~OHDEAR_HEALTH_CHECK_INITIALIZER_TEXT,
          # frozen_string_literal: true

          OhdearHealthCheck.configure do |config|
            # -- Custom checks --
            # config.add_check :cache,        -> { Rails.cache.read('some_key') }
            # config.add_check :environments, -> { Dotenv.require_keys('ENV_NAME', 'ANOTHER_ENV') }
          end
        OHDEAR_HEALTH_CHECK_INITIALIZER_TEXT
      )
      route 'OhdearHealthCheck.routes(self)'
    end
  end
end
