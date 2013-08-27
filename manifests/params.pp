class ssh::params {
  case $::osfamily {
    'Debian': {
      $service_name = 'ssh'
    }
    'RedHat': {
      $service_name = 'sshd'
    }
    default: {
      fail("Unsupported osfamily $::osfamily, currently only supports Debian and RedHat")
    }
  }
  case $::operatingsystem {
    'Debian': {
      case $::operatingsystemrelease {
        /^7.*$/ : {
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
