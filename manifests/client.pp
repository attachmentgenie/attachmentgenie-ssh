class ssh::client {
  package { 'openssh-client':
    ensure => present,
  }
}
