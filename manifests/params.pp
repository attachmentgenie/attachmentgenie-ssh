# Class to manage flink parameters.
#
# Dont include this class directly.
#
class ssh::params {
  $accept_env                      = 'LANG LC_*'
  $address_family                  = 'any'
  $allowed_users                   = []
  $allowed_groups                  = []
  $authorized_keys_file            = ['%h/.ssh/authorized_keys']
  $authorized_keys_command         = undef
  $authorized_keys_command_user    = undef
  $banner_manage                   = false
  $banner_template                 = 'ssh/issue.erb'
  $compression                     = undef
  $client_alive_interval           = 600
  $client_alive_count_max          = 3
  $client_config_template          = 'ssh/ssh_config.erb'
  $client_enable_ssh_key_sign      = 'yes'
  $client_forward_agent            = 'no'
  $client_hostbased_authentication = 'no'
  $client_package_ensure           = 'present'
  $deny_groups                     = []
  $gateway_ports                   = 'no'
  $gssapi_authentication           = 'no'
  $gssapi_keyexchange              = 'no'
  $gssapi_cleanupcredentials       = 'yes'
  $kerberos_authentication         = 'no'
  $known_host_sssd                 = undef
  $manage_service                  = true
  $max_auth_retries                = 2
  $max_sessions                    = 10
  $max_startups                    = '10:30:100'
  $password_authentication_groups  = []
  $password_authentication_users   = []
  $password_authentication         = 'no'
  $permit_root_login               = 'no'
  $permit_tunnel                   = 'no'
  $permit_tty_users                = {}
  $permit_user_environment         = 'no'
  $port                            = '22'
  $print_motd                      = 'no'
  $pubkey_authentication           = 'yes'
  $server_config_template          = 'ssh/sshd_config.erb'
  $server_key_bits                 = '1024'
  $server_package                  = 'openssh-server'
  $server_package_ensure           = 'present'
  $syslog_facility                 = 'AUTH'
  $syslog_level                    = 'VERBOSE'
  $use_pam                         = 'no'
  $use_dns                         = 'yes'
  $x11_forwarding                  = 'no'
  $match                           = {}

  $ciphers53 = ['aes256-ctr',
                'aes192-ctr',
                'aes128-ctr']
  $ciphers66 = ['chacha20-poly1305@openssh.com',
                'aes256-gcm@openssh.com',
                'aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr']

  $host_keys53 = ['/etc/ssh/ssh_host_rsa_key',
                  '/etc/ssh/ssh_host_dsa_key',
                  '/etc/ssh/ssh_host_ecdsa_key']

  $kex59 = ['diffie-hellman-group-exchange-sha256']
  $kex66 = ['curve25519-sha256@libssh.org',
            'diffie-hellman-group-exchange-sha256']

  $macs53 = ['hmac-ripemd160',
              'hmac-sha1']
  $macs59 = ['hmac-sha2-512',
              'hmac-sha2-256,hmac-ripemd160']
  $macs66 = ['hmac-sha2-512-etm@openssh.com',
              'hmac-sha2-256-etm@openssh.com',
              'hmac-ripemd160-etm@openssh.com',
              'umac-128-etm@openssh.com',
              'hmac-sha2-512,hmac-sha2-256',
              'hmac-ripemd160']

  $ps53 = 'yes'
  $ps59 = 'sandbox'

  case $::osfamily {
    'Debian': {
      $banner_file    = 'none'
      $client_package = 'openssh-client'
      $debian_banner  = 'no'
      $service_name   = 'ssh'
      $subsystem_sftp = '/usr/lib/openssh/sftp-server'
      case $::operatingsystemrelease {
        /^7\..*/ : {
          $ciphers                  = $ciphers53
          $host_keys                = $host_keys53
          $kex_algorithms           = $kex59
          $macs                     = $macs59
          $permit_tty               = undef
          $use_privilege_separation = $ps59
        }
        /(^8\..*|^14\.04.*|^16\.04.*)/ : {
          $ciphers                  = $ciphers66
          $host_keys                = $host_keys53
          $kex_algorithms           = $kex66
          $macs                     = $macs66
          $permit_tty               = 'yes'
          $use_privilege_separation = $ps59
        }
        default : {
          $ciphers                  = $ciphers53
          $host_keys                = $host_keys53
          $kex_algorithms           = $kex66
          $macs                     = $macs59
          $permit_tty               = undef
          $use_privilege_separation = $ps59
        }
      }
    }
    'RedHat': {
      $banner_file    = 'none'
      $client_package = 'openssh-clients'
      $debian_banner  = undef
      $service_name   = 'sshd'
      $subsystem_sftp = '/usr/libexec/openssh/sftp-server'
      case $::operatingsystemrelease {
        /^6\..*/ : {
          $ciphers                  = $ciphers53
          $host_keys                = $host_keys53
          $kex_algorithms           = []
          $macs                     = $macs53
          $permit_tty               = undef
          $use_privilege_separation = $ps53
        }
        /^7\..*/ : {
          $ciphers                  = $ciphers66
          $host_keys                = $host_keys53
          $kex_algorithms           = $kex66
          $macs                     = $macs66
          $permit_tty               = 'yes'
          $use_privilege_separation = $ps59
        }
        default : {
          $ciphers                  = $ciphers53
          $host_keys                = $host_keys53
          $kex_algorithms           = $kex66
          $macs                     = $macs59
          $permit_tty               = undef
          $use_privilege_separation = $ps59
        }
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}, currently only supports Debian and RedHat")
    }
  }
}
