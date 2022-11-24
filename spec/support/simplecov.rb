# frozen_string_literal: true

require 'simplecov'
require 'simplecov-console'

SimpleCov.start do
  formatter SimpleCov::Formatter::Console
  minimum_coverage 100

  add_filter { |source_file| !source_file.lines.detect { |line| line.src.match?(/(def |attributes)/) } }

  enable_coverage :branch
end
