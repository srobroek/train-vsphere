# Train-vsphere

`train-vsphere` is a Train plugin and is used as a Train Transport to connect to vsphere environments. 

## To Install this as a User

You will need InSpec v3.9 or later.

Simply run:

```bash
$ inspec plugin install train-vsphere
```

## Using train-vsphere from InSpec
Connect to the vsphere target as such:
```bash
inspec shell -t vsphere://vcenter.host.name --user 'username@sso.domain' --password 'supersecret' --insecure boolean
```
or
```bash
inspec exec -t vsphere://vcenter.host.name --user 'username@sso.domain' --password 'supersecret' --insecure boolean
```

Alternatively you can set all these as environment variables using the following variables and authenticate without the parameters in in the inspec command or the target
```bash
export VC_HOSTNAME='vcenter.host.name'
export VC_USERNAME='username@sso.domain'
export VC_PASSWORD='notVMware1!'
inspec exec -t vsphere://
```

When connected, you can retrieve your API token in your resources or profiles as such:

```ruby
#This retrieves an authentication token
@authtoken = inspec.backend.authenticate

#This authentication token can now be used to access all other APIs
VSphereAutomation::Appliance::AccessConsolecliApi.new(@authtoken).get.value
```

An example of a resource
```ruby
class Vcsa < Inspec.resource(1)
  name 'vcsa'
	supports platform: 'vsphere'
	desc 'Use the vsphere audit resource to get information from the vSphere API'

  def initialize
    begin
      @auth_token = inspec.backend.authenticate
    rescue VSphereAutomation::ApiError => e
          fail Train::ClientError
    end
  end

  def ssh
    begin
     return VSphereAutomation::Appliance::AccessConsolecliApi.new(@auth_token).get.value
        
    rescue VSphereAutomation::ApiError => e
          fail Train::ClientError
    end
  end

  def exists?
    return true
  end

  def authenticate


  end
end

```

And the matching control

```ruby
control 'vcenter-appliance-VCSA-001-1' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'SSH should be disabled'             # A human-readable title
  desc 'SSH should be disabled by default'
  # tag 'security'
  # tag check: 'VCSA-001-1' 
  # ref 'https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.vsphere.vcsa.doc/GUID-D58532F7-E48C-4BF2-87F9-99BA89BF659A.html'
  
  describe vcsa do
    it { should exist }
    its('ssh') {should cmp 'false'}
  end
end
```





## Notes

Due to some unknown bug, libcurl4-gnutls-dev may be required on linux. I haven't tested this on various distributions yet. MacOS should work out of the box, but YMMV. 

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
