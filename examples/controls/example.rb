# encoding: utf-8
# copyright: 2019, Sjors Robroek


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
