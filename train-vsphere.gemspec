

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'train-vsphere/version'

Gem::Specification.new do |spec|
  # Importantly, all Train plugins must be prefixed with `train-`
  spec.name          = 'train-vsphere'

  # It is polite to namespace your plugin under InspecPlugins::YourPluginInCamelCase
  spec.name        = 'train-vsphere'
  spec.version     = TrainPlugins::Vsphere::VERSION
  spec.authors     = ['Sjors Robroek']
  spec.email       = ['s.robroek@vxsan.com']
  spec.summary     = 'Train Transport for vSphere'
  spec.description = 'Allows applications using Train to speak to vSphere'
  spec.homepage    = 'https://github.com/srobroek/train-vsphere'
  spec.license     = 'Apache-2.0'

  # Though complicated-looking, this is pretty standard for a gemspec.
  # It just filters what will actually be packaged in the gem (leaving
  # out tests, etc)
  spec.files = %w{
      README.md train-vsphere.gemspec Gemfile
    } + Dir.glob(
      'lib/**/*', File::FNM_DOTMATCH
    ).reject { |f| File.directory?(f) }
  spec.require_paths = ['lib']


  spec.add_dependency 'train', '~> 1.4'
  spec.add_dependency 'vsphere-automation-sdk', '~> 0.1.0'
  spec.add_dependency 'rbvmomi'
end
