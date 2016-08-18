control 'client 01' do
  impact 1.0
  title 'Verify ssh client'
  desc 'Ensures ssh client should be installed'
  client_package = 'openssh-client'
  client_package = 'openssh-clients' if os[:family] == 'redhat'
  describe package(client_package) do
    it { should be_installed }
  end
end

control 'server 01' do
  impact 1.0
  title 'Verify ssh service'
  desc 'Ensures ssh service is up and running'
  service_name = 'ssh'
  service_name = 'sshd' if os[:family] == 'redhat'
  describe service(service_name) do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

control 'keys 01' do
  impact 1.0
  title 'Verify authorized keys for user vagrant'
  desc 'Ensures authorized keys are set'
  describe file('/home/vagrant/.ssh/authorized_keys') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'vagrant' }
    it { should be_grouped_into 'vagrant' }
    it { should_not be_executable }
    it { should be_readable.by('owner') }
    it { should_not be_readable.by('group') }
    it { should_not be_readable.by('other') }
    it { should be_writable.by('owner') }
    it { should_not be_writable.by('group') }
    it { should_not be_writable.by('other') }
    its('content') { should match /ssh-rsa foobarblabbq vagrant@/ }
  end
end

control 'keys 02' do
  impact 1.0
  title 'Verify authorized keys for user root'
  desc 'Ensures authorized keys are set'
  describe file('/root/.ssh/authorized_keys') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should_not be_executable }
    it { should be_readable.by('owner') }
    it { should_not be_readable.by('group') }
    it { should_not be_readable.by('other') }
    it { should be_writable.by('owner') }
    it { should_not be_writable.by('group') }
    it { should_not be_writable.by('other') }
    its('content') { should match /ssh-rsa foobarblabbq root@/ }
  end
end