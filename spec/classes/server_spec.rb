require 'spec_helper'

describe 'ssh::server', :type => :class do
#  let(:title) { 'postfix::relay' }
  context 'Debian OS 7' do
    let(:facts) { {:operatingsystem => 'Debian', :osfamily => 'Debian', :operatingsystemrelease => '7.1'} }
  it { should contain_package('openssh-server') }
  it do 
   should contain_file('/etc/ssh/sshd_config').with({
     'owner'  => 'root',
     'group'  => 'root',
     'mode'   => '0644',
   })
  end
  it do 
   should contain_file('/etc/ssh/sshd_config').with_content(/\/etc\/ssh\/ssh_host_dsa_key/)
   should contain_file('/etc/ssh/sshd_config').with_content(/\/etc\/ssh\/ssh_host_ecdsa_key/)
  end
  end

  context 'Debian OS 6' do
    let(:facts) { {:operatingsystem => 'Debian', :osfamily => 'Debian', :operatingsystemrelease => '6.0'} }
  it do 
   should contain_file('/etc/ssh/sshd_config').with({
     'owner'  => 'root',
     'group'  => 'root',
     'mode'   => '0644',
   })
  end

    it do 
      should contain_file('/etc/ssh/sshd_config').with_content(/\/etc\/ssh\/ssh_host_dsa_key/)
      should_not contain_file('/etc/ssh/sshd_config').with_content(/\/etc\/ssh\/ssh_host_ecdsa_key/)
    end
  end
end

