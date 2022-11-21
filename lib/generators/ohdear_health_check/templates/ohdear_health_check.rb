# frozen_string_literal: true

OhdearHealthCheck.configure do |config|
  # -- Custom checks --
  # config.add_check :cache,        -> { Rails.cache.read('some_key') }
  # config.add_check :environments, -> { Dotenv.require_keys('ENV_NAME', 'ANOTHER_ENV') }
end
