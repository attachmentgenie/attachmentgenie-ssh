class ssh::server (
  $port                           = $::ssh::params::port,
  $allowed_users                  = $::ssh::params::allowed_users,
  $allowed_groups                 = $::ssh::params::allowed_groups,
  $password_authentication_groups = $::ssh::params::password_authentication_groups,
  $password_authentication_users  = $::ssh::params::password_authentication_users,
  $x11_forwarding                 = $::ssh::params::x11_forwarding,
  $use_dns                        = $::ssh::params::use_dns,
  $password_authentication        = $::ssh::params::password_authentication,
  $pubkey_authentication          = $::ssh::params::pubkey_authentication,
  $subsystem_sftp                 = $::ssh::params::subsystem_sftp,
  $use_pam                        = $::ssh::params::use_pam,
  $permit_root_login              = $::ssh::params::permit_root_login,
  $print_motd                     = $::ssh::params::print_motd,
  $host_keys                      = $::ssh::params::host_keys,
  $manage_service                 = $::ssh::params::manage_service,
  $banner                         = $::ssh::params::banner,
  $manage_banner                  = $::ssh::params::manager_banner,
  $template_banner                = $::ssh::params::template_banner,
  $content_banner                 = $::ssh::params::content_banner,
  $ciphers                        = $::ssh::params::ciphers,
  $macs                           = $::ssh::params::macs,
  $client_alive_interval          = $::ssh::params::client_alive_interval,
  $client_alive_count_max         = $::ssh::params::client_alive_count_max,
  $template                       = $::ssh::params::template,
  $accept_env                     = $::ssh::params::accept_env
) inherits ssh::params {
  package { 'openssh-server':
    ensure => present,
  }

  file { '/etc/ssh/sshd_config':
    content => template($template),
    require => Package['openssh-server'],
    owner   => root,
    group   => root,
    mode    => '0644'
  }

  if str2bool($manage_service) {
    service { 'ssh':
      ensure    => running,
      name      => $ssh::params::service_name,
      enable    => true,
      hasstatus => true,
      subscribe => [Package['openssh-server'], File['/etc/ssh/sshd_config']],
      require   => File['/etc/ssh/sshd_config'],
    }
  }

  if str2bool($manage_banner) {
    file { $banner:
      content => template($template_banner),
      require => Package['openssh-server'],
      owner   => root,
      group   => root,
      mode    => '0644'
    }
  }

  if $permit_root_login == 'yes' {
    notify { 'You permit root login: use it with caution.': }
  }
}
