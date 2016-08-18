class ssh::client (
  $enable_ssh_key_sign      = $::ssh::params::client_enable_ssh_key_sign,
  $forward_agent            = $::ssh::params::client_forward_agent,
  $hostbased_authentication = $::ssh::params::client_hostbased_authentication,
  $known_host_sssd          = $::ssh::params::known_host_sssd,
  $password_authentication  = $::ssh::params::client_password_authentication,
  $template                 = $::ssh::params::client_config_template,
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
