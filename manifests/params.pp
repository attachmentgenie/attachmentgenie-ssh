class ssh::params {
  $accept_env                      = 'LANG LC_*'
  $address_family                  = undef
  $allowed_users                   = []
  $allowed_groups                  = []
  $authorized_keys_file            = ['%h/.ssh/authorized_keys']
  $authorized_keys_command         = undef
  $authorized_keys_command_user    = undef
  $banner_manage                   = true
  $banner_template                 = 'ssh/issue.erb'
  $ciphers                         = []
  $client_alive_interval           = undef
  $client_alive_count_max          = undef
  $client_config_template          = 'ssh/ssh_config.erb'
  $client_enable_ssh_key_sign      = 'yes'
  $client_forward_agent            = 'no'
  $client_hostbased_authentication = 'no'
  $gateway_ports                   = 'no'
  $gssapi_authentication           = 'no'
  $known_host_sssd                 = undef
  $manage_service                  = true
  $max_auth_retries                = 6
  $macs                            = []
  $password_authentication_groups  = []
  $password_authentication_users   = []
  $permittty_no_users              = []
  $permittty_yes_users             = []
  $password_authentication         = 'no'
  $permit_root_login               = 'no'
  $permit_tunnel                   = 'no'
  $permit_user_environment         = 'no'
  $port                            = '22'
  $print_motd                      = 'no'
  $pubkey_authentication           = 'yes'
  $server_config_template          = 'ssh/sshd_config.erb'
  $server_key_bits                 = '1024'
  $syslog_facility                 = 'AUTH'
  $syslog_level                    = 'INFO'
  $use_pam                         = 'yes'
  $use_dns                         = 'yes'
  $x11_forwarding                  = 'no'
  case $::osfamily {
    'Debian': {
      $subsystem_sftp  = '/usr/lib/openssh/sftp-server'
      $service_name = 'ssh'
      $banner_file  = '/etc/issue.net'
    }
    'RedHat': {
      $subsystem_sftp  = '/usr/libexec/openssh/sftp-server'
      $service_name = 'sshd'
      $banner_file  = '/etc/issue'
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}, currently only supports Debian and RedHat")
    }
  }
  case $::operatingsystem {
    'Debian': {
      case $::operatingsystemrelease {
        /^[78].*$/ : {
          $host_keys=['/etc/ssh/ssh_host_rsa_key','/etc/ssh/ssh_host_dsa_key','/etc/ssh/ssh_host_ecdsa_key']
        }
        default : {
          $host_keys=['/etc/ssh/ssh_host_rsa_key','/etc/ssh/ssh_host_dsa_key']
        }
      }
    }
    default : {
      $host_keys=['/etc/ssh/ssh_host_rsa_key','/etc/ssh/ssh_host_dsa_key']
    }
  }
}
