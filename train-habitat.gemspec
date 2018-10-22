# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'train-habitat/version'

Gem::Specification.new do |spec|
  spec.name        = 'train-habitat'
  spec.version     = TrainPlugins::Habitat::VERSION
  spec.authors     = ['Chef InSpec Team']
  spec.email       = ['inspec@chef.io']
  spec.summary     = 'Habitat API Transport for Train'
  spec.description = 'Allows applications using Train to speak to Habitat.'
  spec.homepage    = 'https://github.com/inspec/train-habitat'
  spec.license     = 'Apache-2.0'

  spec.files = %w{
    README.md train-aws.gemspec Gemfile
  } + Dir.glob(
    'lib/**/*', File::FNM_DOTMATCH
  ).reject { |f| File.directory?(f) }
  spec.require_paths = ['lib']

  # All plugins should mention train, > 1.4
  spec.add_dependency 'train', '>= 1.5'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
