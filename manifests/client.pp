class ssh::client (
  $template = $::ssh::params::client_config_template,
) inherits ssh::params {
  case $::osfamily {
      'RedHat': { $sshclientpkg = 'openssh-clients' }
      'Debian': { $sshclientpkg = 'openssh-client' }
      default: { fail("Unsupported osfamily ${::osfamily}, currently only supports Debian and RedHat") }
      }
  package { $sshclientpkg:
    ensure => present,
  }

  file { '/etc/ssh/ssh_config':
    content => template($template),
    require => Package[$sshclientpkg],
    owner   => root,
    group   => root,
    mode    => '0644'
  }
}
