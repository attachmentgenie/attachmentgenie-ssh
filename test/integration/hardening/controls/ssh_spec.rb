control 'client 01' do
  impact 1.0
  title 'Verify ssh client'
  desc 'Ensures ssh client should be installed'
  client_package = 'openssh-client'
  client_package = 'openssh-clients' if os[:family] == 'redhat'
  describe package(client_package) do
    it { is_expected.to be_installed }
  end
end

control 'server 01' do
  impact 1.0
  title 'Verify ssh service'
  desc 'Ensures ssh service is up and running'
  service_name = 'ssh'
  service_name = 'sshd' if os[:family] == 'redhat'
  describe service(service_name) do
    it { is_expected.to be_enabled }
    it { is_expected.to be_installed }
    it { is_expected.to be_running }
  end
end

control 'keys 01' do
  impact 1.0
  title 'Verify authorized keys for user vagrant'
  desc 'Ensures authorized keys are set'
  describe file('/home/vagrant/.ssh/authorized_keys') do
    it { is_expected.to exist }
    it { is_expected.to be_file }
    it { is_expected.to be_owned_by 'vagrant' }
    it { is_expected.to be_grouped_into 'vagrant' }
    it { is_expected.not_to be_executable }
    it { is_expected.to be_readable.by('owner') }
    it { is_expected.not_to be_readable.by('group') }
    it { is_expected.not_to be_readable.by('other') }
    it { is_expected.to be_writable.by('owner') }
    it { is_expected.not_to be_writable.by('group') }
    it { is_expected.not_to be_writable.by('other') }
  end
end

include_controls 'ssh-baseline'
