class ssh::server(
  $port='22',
  $allowed_users=[],
  $allowed_groups=[],
  $x11_forwarding='no',
  $password_authentication='no',
  $subsystem_sftp='/usr/lib/openssh/sftp-server',
  $permit_root_login='no',
  $host_keys=$ssh::params::host_keys,
  $manage_service=true
) inherits ssh::params {
  package { 'openssh-server':
    ensure => present,
  }

  file { '/etc/ssh/sshd_config':
    content => template('ssh/sshd_config.erb'),
    require => Package['openssh-server'],
    owner => root,
    group => root,
    mode  => '0644'
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

  if $permit_root_login == 'true' {
    notify { "You permit root login: use it with caution.": }
  }
}
