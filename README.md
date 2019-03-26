# Train-Habitat

`train-habitat` is a Train plugin and is used as a Train Transport to connect to Habitat installations.

## To Install this as a User

You will need InSpec v2.3 or later.

Simply run:

```
$ inspec plugin install train-habitat
```

## Using train-habitat from InSpec

As `train-habitat` takes potentially many options, it is simplest to list the options in your `~/.inspec/config.json` file, then used the named set of options with `-t`.

For example, if your config file contains:

```
{
  "file_version": "1.1",
  "credentials": {
    "habitat": {
      "dev-hab": {
        "api_url": "http://dev-hab.my-corp.io",
        "cli_ssh_host": "dev-hab.my-corp.io"
      },
      "prod-hab": {
        "api_url": "https://prod-hab.my-corp.io",
        "api_auth_token": "opensesame"
      },
    }
  }
}
```

Using this configuration, you could execute:

```
$ inspec exec some-profile -t habitat://dev-hab
# Or
$ inspec exec some-profile -t habitat://prod-hab
```

You may also pass `--config some-file.json` to use a config file at a different location.

See the next section for the full list of options you may use with a `habitat` credential set in your configuration.

## Using train-habitat from Ruby

The options that may be passed to `Train.create` are listed below.

### Dual-mode transport

Because Habitat exposes some facts by its HTTP Gateway API, and some facts by its CLI tool `hab`, this Train Transport has three modes of operation:

 * Using only the HTTP API (no ability to query packages, but rich ability to query rings)
 * Using only the `hab` CLI command (limitations TBD)
 * Using both (full capabilities)

When creating a `train-habitat` Connection, there are thus two sets of options, prefixed with `api_` and `cli_` respectively. You must provide at least one set.

### API-Mode options

API-mode options are used to connect to a Habitat Supervisor running with an exposed HTTP Gateway. They are prefixed with `api_`.

```ruby
Train.create(:habitat, api_url: 'http://my-hab.my-company.io:9631')
```

#### api_url

Required for API-mode use. This is an HTTP or HTTPS URL that identifies a Supervisor HTTP Gateway.  If the port is omitted from the URL, the API standard port of 9631 is assumed; to use port 80, specify it explicitly.

#### api_auth_token

The supervisor may be configured to require a [Bearer Token Authorization](https://www.habitat.sh/docs/using-habitat/#monitor-services-through-the-http-api), in which the client and the gateway use a pre-shared secret. Use this option to specify the secret.

### CLI Mode options

CLI options are more varied, and are entirely dependent on the underlying transport chosen to reach the CLI. For example, if there were a supported transport named 'radio' that took options 'channel' and 'band', specify them to train-habitat like this:

```ruby
Train.create(:habitat, {cli_radio_band: 'VHF', cli_radio_channel: 23})
```

`train-habitat` identifies the underlying "sub-transport" using the prefixes of the provided options. For example, if you pass an option named `cli_ssh_host`, `train-habitat` will recognize that you intend to use the SSH transport to connect to a location that has access to the `hab` CLI tool.

You may specify many options referring to the same sub-transport (such as credentials), but it is an error to specify more than one CLI sub-transport.

Currently supported CLI transports include:
 * SSH

Plans for future support include (in approximate order):
 * WinRM
 * Local
 * Docker

#### General Options

Any options not prefixed with `cli_` or `api_` are also passed to the CLI transport. This means you can use generic Train connection options such as the `sudo` and `shell` sets of options (see [train source code](https://github.com/inspec/train/blob/71679307903fc8853e09abd93f3901c83800e019/lib/train/extras/command_wrapper.rb#L31)), as well as `logger`.

#### SSH Options

`train-habitat` can accept any option that the Train SSH Transport accepts if the prefix `cli_ssh_` is added. This includes:

 * `cli_ssh_host` - String hostname or IP address
 * `cli_ssh_user` - String user to connect as
 * `cli_ssh_key_files` - Array of paths to private key files to use

Other options are available; see [train source code](https://github.com/inspec/train/blob/71679307903fc8853e09abd93f3901c83800e019/lib/train/transports/ssh.rb#L45) for details.

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

| **Author:**          | Paul Welch

| **Author:**          | David McCown

| **Author:**          | Clinton Wolfe

| **Copyright:**       | Copyright (c) 2018-2019 Chef Software Inc.

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
