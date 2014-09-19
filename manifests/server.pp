class ssh::server (
  $port='22',
  $allowed_users=[],
  $allowed_groups=[],
  $password_authentication_groups=[],
  $password_authentication_users=[],
  $x11_forwarding='no',
  $use_dns='yes',
  $password_authentication='no',
  $pubkey_authentication='yes',
  $subsystem_sftp='/usr/lib/openssh/sftp-server',
  $use_pam='yes',
  $permit_root_login='no',
  $print_motd = $ssh::params::print_motd,
  $host_keys=$ssh::params::host_keys,
  $manage_service=true,
  $banner=undef
) inherits ssh::params {
  package { 'openssh-server':
    ensure => present,
  }

  file { '/etc/ssh/sshd_config':
    content => template('ssh/sshd_config.erb'),
    require => Package['openssh-server'],
    owner   => root,
    group   => root,
    mode    => '0644'
  }

  if $manage_service {
    service { 'ssh':
      ensure    => running,
      name      => $ssh::params::service_name,
      enable    => true,
      hasstatus => true,
      subscribe => [Package['openssh-server'], File['/etc/ssh/sshd_config']],
      require   => File['/etc/ssh/sshd_config'],
    }
  }

  if $permit_root_login == 'yes' {
    notify { 'You permit root login: use it with caution.': }
  }
}
