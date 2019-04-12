

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'train-vsphere/version'

Gem::Specification.new do |spec|
  spec.name        = 'train-vsphere'
  spec.version     = TrainPlugins::Vsphere::VERSION
  spec.authors     = ['Sjors Robroek']
  spec.email       = ['s.robroek@vxsan.com']
  spec.summary     = 'Train Transport for vSphere'
  spec.description = 'Allows applications using Train to speak to vSphere'
  spec.homepage    = 'https://github.com/srobroek/train-vsphere'
  spec.license     = 'Apache-2.0'

  spec.files = %w{
    README.md train-vsphere.gemspec Gemfile
  } + Dir.glob(
    'lib/**/*', File::FNM_DOTMATCH
  ).reject { |f| File.directory?(f) }
  spec.require_paths = ['lib']

spec.add_dependency 'train', '~> 1.4'
end
