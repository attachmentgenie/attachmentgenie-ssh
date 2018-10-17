require 'spec_helper'
describe 'ssh::server', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with defaults for all parameters' do
        it { is_expected.to contain_class('ssh::server') }
        it { is_expected.to contain_class('ssh::params') }
        it do
          is_expected.to contain_package('openssh-server').with(
            'ensure' => 'present',
          )
        end
        it do
          is_expected.to contain_file('/etc/ssh/sshd_config').with(
            'owner' => 'root',
            'group' => 'root',
            'mode'  => '0600',
          )
        end
        it do
          is_expected.to contain_service('sshd').with(
            'ensure' => 'running',
          )
        end
      end
    end
  end
end
