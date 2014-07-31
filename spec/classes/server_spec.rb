require 'spec_helper'

describe 'ssh::server', :type => :class do
  context "on a Debian OS 6" do
    let :facts do
      {
        :id                     => 'root',
        :kernel                 => 'Linux',
        :lsbdistcodename        => 'squeeze',
        :osfamily               => 'Debian',
        :operatingsystem        => 'Debian',
        :operatingsystemrelease => '6',
        :path                   => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        :concat_basedir         => '/dne',
      }
    end
    it { is_expected.to contain_package("openssh-server").with(
      'ensure' => 'present'
      )
    }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with(
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
      )
    }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^HostKey /etc/ssh/ssh_host_rsa_key$} }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^HostKey /etc/ssh/ssh_host_dsa_key$} }
  end
  context "on a Debian OS 7" do
    let :facts do
      {
        :id                     => 'root',
        :kernel                 => 'Linux',
        :lsbdistcodename        => 'wheezy',
        :osfamily               => 'Debian',
        :operatingsystem        => 'Debian',
        :operatingsystemrelease => '7',
        :path                   => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        :concat_basedir         => '/dne',
      }
    end
    it { is_expected.to contain_package("openssh-server").with(
      'ensure' => 'present'
      )
    }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with(
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
      )
    }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^HostKey /etc/ssh/ssh_host_rsa_key$} }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^HostKey /etc/ssh/ssh_host_dsa_key$} }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^HostKey /etc/ssh/ssh_host_ecdsa_key$} }
  end
end
