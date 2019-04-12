# Train-vsphere

`train-vsphere` is a Train plugin and is used as a Train Transport to connect to vsphere environments. 

## To Install this as a User

This has been built on inspec 3.9 but it will probably work on earlier versions; YMMV. 


Simply run:

```
$ inspec plugin install train-vsphere
```

## Using train-vsphere from InSpec
TODO


### API-Mode options

TODO


#### api_url

TODO

## Development

### Testing
```
# Install development tools
$ gem install bundler
$ bundle install

# Running style checker
bundle exec rake lint

# Running unit tests
bundle exec rake test:unit

# Running integration tests (requires Vagrant and VirtualBox)
bundle exec rake test:integration
```

## Contributing

1. Fork it
1. Create your feature branch (git checkout -b my-new-feature)
1. Commit your changes (git commit -sam 'Add some feature')
1. Push to the branch (git push origin my-new-feature)
1. Create new Pull Request

## License

| **Author:**          | Sjors Robroek

| **Copyright:**       | Copyright (c) 2019

| **License:**         | Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
