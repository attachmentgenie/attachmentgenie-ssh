class ssh::client inherits ssh::params {
  package { 'openssh-client':
    ensure => present,
  }
}
