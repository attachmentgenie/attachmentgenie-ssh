class ssh::params {
  $accept_env                      = 'LANG LC_*'
  $allowed_users                   = []
  $allowed_groups                  = []
  $authorized_keys_file            = ['%h/.ssh/authorized_keys']
  $banner_manage                   = true
  $banner_template                 = 'ssh/issue.erb'
  $client_alive_interval           = undef
  $client_alive_count_max          = undef
  $client_config_template          = 'ssh/ssh_config.erb'
  $client_enable_ssh_key_sign      = 'yes'
  $client_forward_agent            = 'no'
  $client_hostbased_authentication = 'no'
  $manage_service                  = true
  $max_auth_retries                = 6
  $ciphers                         = []
  $macs                            = []
  $password_authentication_groups  = []
  $password_authentication_users   = []
  $password_authentication         = 'no'
  $permit_root_login               = 'no'
  $permit_tunnel                   = 'no'
  $gateway_ports                   = 'no'
  $port                            = '22'
  $print_motd                      = 'no'
  $pubkey_authentication           = 'yes'
  $server_config_template          = 'ssh/sshd_config.erb'
  $subsystem_sftp                  = '/usr/lib/openssh/sftp-server'
  $use_pam                         = 'yes'
  $use_dns                         = 'yes'
  $x11_forwarding                  = 'no'
  $server_key_bits                 = '1024'
  $kex_algorithms                  = []

  case $::osfamily {
    'Debian': {
      $service_name       = 'ssh'
      $banner_file        = '/etc/issue.net'
      case $::operatingsystemrelease {
        /(7.*|12\.04.*)/ : {
          $host_keys      = ['/etc/ssh/ssh_host_rsa_key','/etc/ssh/ssh_host_dsa_key','/etc/ssh/ssh_host_ecdsa_key']
        }
        /(8.*|14\.04.*)/ : {
          $host_keys      = ['/etc/ssh/ssh_host_rsa_key','/etc/ssh/ssh_host_dsa_key','/etc/ssh/ssh_host_ecdsa_key']
        }
        default : {
          $host_keys      = ['/etc/ssh/ssh_host_rsa_key','/etc/ssh/ssh_host_dsa_key']
        }
      }
    }
    'RedHat': {
      $service_name = 'sshd'
      $banner_file  = '/etc/issue'
      case $::operatingsystemrelease {
        /6.*/ : {
          $host_keys      = ['/etc/ssh/ssh_host_rsa_key','/etc/ssh/ssh_host_dsa_key']
        }
        /7.*/ : {
          $host_keys      = ['/etc/ssh/ssh_host_rsa_key','/etc/ssh/ssh_host_dsa_key','/etc/ssh/ssh_host_ecdsa_key']
        }
        default : {
          $host_keys      = ['/etc/ssh/ssh_host_rsa_key','/etc/ssh/ssh_host_dsa_key']
        }
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}, currently only supports Debian and RedHat")
    }
  }
}
