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
}
