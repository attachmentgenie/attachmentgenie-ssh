class ssh::params {
  $port                           = '22'
  $allowed_users                  = []
  $allowed_groups                 = []
  $password_authentication_groups = []
  $password_authentication_users  = []
  $x11_forwarding                 = 'no'
  $use_dns                        = 'yes'
  $password_authentication        = 'no'
  $pubkey_authentication          = 'yes'
  $subsystem_sftp                 = '/usr/lib/openssh/sftp-server'
  $use_pam                        = 'yes'
  $permit_root_login              = 'no'
  $print_motd                     = 'no'
  $manage_service                 = true
  $manage_banner                  = false
  $template_banner                = 'ssh/issue.erb'
  $content_banner                 = $::fqdn
  $ciphers                        = []
  $macs                           = []
  $client_alive_interval          = undef
  $client_alive_count_max         = undef
  $client_config_template         = 'ssh/ssh_config.erb'
  $server_config_template         = 'ssh/sshd_config.erb'
  $accept_env                     = 'LANG LC_*'
  case $::osfamily {
    'Debian': {
      $service_name = 'ssh'
      $banner       = '/etc/issue.net'
    }
    'RedHat': {
      $service_name = 'sshd'
      $banner       = '/etc/issue'
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
