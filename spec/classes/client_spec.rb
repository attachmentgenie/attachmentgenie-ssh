require 'spec_helper'
describe 'ssh::client', :type => :class do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with defaults for all parameters' do
        it { should contain_class('ssh::client') }
        it { is_expected.to contain_package('openssh-client').with(
            'ensure' => 'present'
        ) }
        it { is_expected.to contain_file('/etc/ssh/ssh_config').with(
            'owner' => 'root',
            'group' => 'root',
            'mode'  => '0644'
        ) }
      end
    end
  end
end
