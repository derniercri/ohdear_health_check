# frozen_string_literal: true

require_relative 'lib/ohdear_health_check/version'

Gem::Specification.new do |spec|
  spec.name    = 'ohdear_health_check'
  spec.version = OhdearHealthCheck::VERSION
  spec.authors = ['Dernier Cri']
  spec.email   = ['dev@derniercri.io']

  spec.summary     = 'OhDear Health Check'
  spec.description = 'Formats health check payload for OhDear service'
  spec.homepage    = 'https://github.com/derniercri/ohdear_health_check'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/derniercri/ohdear_health_check'
  spec.metadata['changelog_uri']   = 'https://github.com/derniercri/ohdear_health_check/blob/develop/CHANGELOG.md'

  spec.required_ruby_version = '>= 2.5.9'

  spec.files = Dir['{app}/**/*', '{lib}/**/*', 'README.md']

  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.add_dependency 'actionpack'
  spec.add_dependency 'railties'

  spec.add_development_dependency 'bundler', '~> 2.3'
  spec.add_development_dependency 'minitest', '~> 5.15.0'
  spec.add_development_dependency 'nokogiri', '~> 1.12.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec-rails', '~> 6.0'
  spec.add_development_dependency 'rubocop', '~> 1.28.0'
  spec.add_development_dependency 'rubocop-ast', '~> 1.17.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.13.0'
  spec.add_development_dependency 'simplecov', '~> 0.21'
  spec.add_development_dependency 'simplecov-console', '~> 0.9'
  spec.add_development_dependency 'timecop', '~> 0.9'
end
