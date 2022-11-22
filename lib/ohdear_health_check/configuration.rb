# frozen_string_literal: true

module OhdearHealthCheck
  class Configuration
    SETTINGS = %i[checks].freeze
    DETECTABLE_CHECKS = %i[Redis Sidekiq].freeze

    attr_accessor(*SETTINGS)

    def initialize
      clear!
      add_default_checks
    end

    def add_check(name, block, success_message = nil, error_message = nil)
      @checks << Check.new(name, block, success_message, error_message)
    end

    def clear!
      @checks = []
    end

    private

    def add_redis
      return unless defined?(Redis)

      add_check :redis, -> { Redis.new.ping }, 'Redis is up', 'Redis is down'
    end

    def add_sidekiq
      return unless defined?(Sidekiq)

      block = lambda do
        return if Sidekiq::Stats.new.processes_size >= 1

        raise OhdearHealthCheck::Check::Error, 'Sidekiq is down'
      end

      add_check :sidekiq, block, 'Sidekiq is up'
    end

    def add_default_checks
      add_check :database,   -> { ActiveRecord::Base.connection.execute('select 1') }, 'Database is up'
      add_check :migrations, -> { ActiveRecord::Migration.check_pending! }, 'Migrations are up to date'
      add_redis
      add_sidekiq
    end
  end
end
