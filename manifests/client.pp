class ssh::client inherits ssh::params {
  case $::osfamily {
      'RedHat': { $sshclientpkg = 'openssh-clients' }
      'Debian': { $sshclientpkg = 'openssh-client' }
      default: { fail("Unsupported osfamily ${::osfamily}, currently only supports Debian and RedHat") }
      }
  package { $sshclientpkg:
    ensure => present,
  }
}
