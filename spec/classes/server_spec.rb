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
      'mode'   => '0644'
      )
    }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^HostKey /etc/ssh/ssh_host_rsa_key$} }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^HostKey /etc/ssh/ssh_host_dsa_key$} }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^Banner /etc/issue.net$} }
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
    let :params do
      {
        :banner_file            => '/etc/banner.txt',
        :ciphers                => ['aes128-ctr','aes192-ctr','aes256-ctr','arcfour256','arcfour128'],
        :macs                   => ['hmac-sha1','hmac-ripemd160'],
        :gateway_ports          => 'clientspecified',
        :client_alive_interval  => '30',
        :client_alive_count_max => '5'
      }
    end
    it { is_expected.to contain_package("openssh-server").with(
      'ensure' => 'present'
      )
    }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with(
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644'
      )
    }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^HostKey /etc/ssh/ssh_host_rsa_key$} }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^HostKey /etc/ssh/ssh_host_dsa_key$} }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^HostKey /etc/ssh/ssh_host_ecdsa_key$} }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^Banner /etc/banner.txt$} }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^Ciphers aes128-ctr,aes192-ctr,aes256-ctr,arcfour256,arcfour128$} }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^MACs hmac-sha1,hmac-ripemd160$} }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^ClientAliveInterval 30$} }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^ClientAliveCountMax 5$} }
    it { is_expected.to contain_file("/etc/ssh/sshd_config").with_content %r{^GatewayPorts clientspecified$} }
  end
end
