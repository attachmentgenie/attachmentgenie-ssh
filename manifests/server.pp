class ssh::server (
  $accept_env                     = $::ssh::params::accept_env,
  $allowed_users                  = $::ssh::params::allowed_users,
  $allowed_groups                 = $::ssh::params::allowed_groups,
  $authorized_keys_file           = $::ssh::params::authorized_keys_file,
  $banner_file                    = $::ssh::params::banner_file,
  $banner_manage                  = $::ssh::params::banner_manage,
  $banner_template                = $::ssh::params::banner_template,
  $ciphers                        = $::ssh::params::ciphers,
  $client_alive_interval          = $::ssh::params::client_alive_interval,
  $client_alive_count_max         = $::ssh::params::client_alive_count_max,
  $host_keys                      = $::ssh::params::host_keys,
  $macs                           = $::ssh::params::macs,
  $manage_service                 = $::ssh::params::manage_service,
  $max_auth_retries               = $::ssh::params::max_auth_retries,
  $password_authentication        = $::ssh::params::password_authentication,
  $password_authentication_groups = $::ssh::params::password_authentication_groups,
  $password_authentication_users  = $::ssh::params::password_authentication_users,
  $permit_root_login              = $::ssh::params::permit_root_login,
  $permit_tunnel                  = $::ssh::params::permit_tunnel,
  $permit_user_environment        = $::ssh::params::permit_user_environment,
  $gateway_ports                  = $::ssh::params::gateway_ports,
  $print_motd                     = $::ssh::params::print_motd,
  $pubkey_authentication          = $::ssh::params::pubkey_authentication,
  $subsystem_sftp                 = $::ssh::params::subsystem_sftp,
  $template                       = $::ssh::params::server_config_template,
  $use_dns                        = $::ssh::params::use_dns,
  $use_pam                        = $::ssh::params::use_pam,
  $x11_forwarding                 = $::ssh::params::x11_forwarding,
  $server_key_bits                = $::ssh::params::server_key_bits,
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

  if str2bool($banner_manage) {
    file { $banner_file:
      content => template($banner_template),
      require => Package['openssh-server'],
      owner   => root,
      group   => root,
      mode    => '0644'
    }
  }
}
