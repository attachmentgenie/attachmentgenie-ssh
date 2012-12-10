class ssh::server($port='22', $allowed_users=[]) inherits ssh::params {
  package { 'openssh-server':
    ensure => present,
  }

  file { '/etc/ssh/sshd_config':
    content => template('ssh/sshd_config.erb'),
    require => Package['openssh-server'],
  }

  service { 'ssh':
    name      => $ssh::params::service_name,
    ensure    => running,
    enable    => true,
    hasstatus => true,
    subscribe => [Package['openssh-server'], File['/etc/ssh/sshd_config']],
    require   => File['/etc/ssh/sshd_config'],
  }
}
