control 'Habitat Service' do
  describe command('/bin/hab') do
    it { should exist }
  end

  describe user('hab') do
    it { should exist }
  end

  describe group('hab') do
    it { should exist }
  end

  describe systemd_service('habitat') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe http('http://0.0.0.0:9631/services') do
    its('status') { should cmp 200 }
  end
end

control 'Test httpd hab service' do
  describe http('http://0.0.0.0/') do
    its('status') { should cmp 200 }
  end
end
