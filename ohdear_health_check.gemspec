# frozen_string_literal: true

require_relative 'lib/ohdear_health_check/version'

Gem::Specification.new do |spec|
  spec.name = 'ohdear_health_check'
  spec.version = OhdearHealthCheck::VERSION
  spec.authors = ['Dernier Cri']
  spec.email = ['dev@derniercri.io']

  spec.summary = 'OhDear Health Check'
  spec.description = 'Formats health check payload for OhDear service'
  spec.homepage = 'https://github.com/derniercri/ohdear_health_check'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/derniercri/ohdear_health_check'
  spec.metadata['changelog_uri'] = 'https://github.com/derniercri/ohdear_health_check/blob/develop/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.add_dependency 'actionpack'
  spec.add_dependency 'railties'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'redis'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'sidekiq'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-console'
  spec.add_development_dependency 'timecop'
end
