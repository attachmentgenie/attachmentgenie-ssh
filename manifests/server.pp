# Class to install and configure ssh server.
#
# Use this module to install and configure ssh server.
#
# @example Declaring the class
#   include ::ssh::server
#
# @param package (String) Package name.
# @param package_ensure (String) Standard puppet package ensure.
# @param accept_env (String) Specifies what environment variables sent by the client will be copied into the session's environ.
# @param address_family (String) Specifies which address family should be used by sshd(8).
# @param allowed_users (Array) If specified, login is allowed only for user names that match one of the patterns.
# @param allowed_groups (Array)  If specified, login is allowed only for users whose primary group or supplementary group list matches one of the pattern.
# @param authorized_keys_file (String) Specifies the file that contains the public keys that can be used for user authentication.
# @param authorized_keys_command (String) Specifies a program to be used for lookup of the user's public keys.
# @param authorized_keys_command_user (String) Specifies the user under whose account the AuthorizedKeysCommand is run.
# @param banner_file (String) The contents of the specified file are sent to the remote user before authentication is allowed.
# @param banner_manage (Boolean) Manage the banner file.
# @param banner_template (String) Template to use for banner file.
# @param compression (String) Specifies whether compression is allowed, or delayed until the user has authenticated successfully.
# @param ciphers (Array) Specifies the ciphers allowed for protocol version 2.
# @param client_alive_interval (Integer) Sets a timeout interval in seconds after which if no data has been received from the client.
# @param client_alive_count_max (Integer) Sets the number of client alive messages (see below) which may be sent without sshd(8) receiving any messages back from the client.
# @param deny_groups (Array) Login is disallowed for users whose primary group or supplementary group list matches one of the patterns.
# @param debian_banner (String) Specifies whether the distribution-specified extra version suffix is included during initial protocol handshake.
# @param gssapi_authentication (String) Specifies whether user authentication based on GSSAPI is allowed.
# @param gssapi_keyexchange (String) Specifies whether key exchange based on GSSAPI is allowed.
# @param gssapi_cleanupcredentials (String) Specifies whether to automatically destroy the user's credentials cache on logout.
# @param host_keys (Array) Specifies a file containing a private host key used by SSH.
# @param kerberos_authentication (String) Specifies whether the password provided by the user for PasswordAuthentication will be validated through the Kerberos KDC.
# @param macs (Array) Specifies the available MAC (message authentication code) algorithms.
# @param manage_service (Boolean) Manage sshd service.
# @param max_auth_retries (Integer) Specifies the maximum number of authentication attempts permitted per connection.
# @param max_sessions (Integer) Specifies the maximum number of open sessions permitted per network connection.
# @param max_startups (Integer) Specifies the maximum number of concurrent unauthenticated connections to the SSH daemon.
# @param password_authentication (String) Specifies whether password authentication is allowed.
# @param password_authentication_groups (Array) Introduces a conditional block. If all of the criteria on the Match line are satisfied, the keywords on the following lines override those set in the global section of the config file, until either another Match line or the end of the file.
# @param password_authentication_users (Array) Introduces a conditional block. If all of the criteria on the Match line are satisfied, the keywords on the following lines override those set in the global section of the config file, until either another Match line or the end of the file.
# @param permit_root_login (String) Specifies whether root can log in using ssh.
# @param permit_tunnel (String) Specifies whether tun(4) device forwarding is allowed.
# @param permit_tty (String) Specifies whether pty(4) allocation is permitted.
# @param permit_tty_users (Hash) Introduces a conditional block. If all of the criteria on the Match line are satisfied, the keywords on the following lines override those set in the global section of the config file, until either another Match line or the end of the file.
# @param permit_user_environment (String) Specifies whether ~/.ssh/environment and environment= options in ~/.ssh/authorized_keys are	processed by sshd.
# @param port (Integer) Specifies the port	number that sshd listens on.
# @param gateway_ports (String) Specifies whether remote hosts are	allowed	to connect to ports forwarded for the client.
# @param print_motd (String) Specifies whether sshd(8) should print /etc/motd when a user logs in	interactively.
# @param pubkey_authentication (String) Specifies whether public key authentication is allowed.
# @param server_key_bits (String) Defines the number	of bits	in the ephemeral protocol version 1 server key.
# @param service_name (String) Ssh service name.
# @param subsystem_sftp (String) Configures	an external subsystem for sftp.
# @param syslog_facility (String) Gives the facility	code that is used when logging messages	from sshd.
# @param syslog_level (String) Gives the verbosity level that is used when logging messages from sshd.
# @param template (String) Template to use for config.
# @param use_dns (String) pecifies whether sshd(8) should look up the remote host name, and to check that the resolved host name for the remote IP address maps back to the very same	IP address.
# @param use_pam (String) Enables the Pluggable Authentication Module interface.
# @param x11_forwarding (String) Specifies whether X11 forwarding is permitted.
# @param match (Hash) # @param password_authentication_users (Array) Introduces a conditional block. If all of the criteria on the Match line are satisfied, the keywords on the following lines override those set in the global section of the config file, until either another Match line or the end of the file.
# @param kex_algorithms (Hash) Specifies the available KEX (Key Exchange)	algorithms.
# @param use_privilege_separation (String) Specifies whether sshd(8) separates privileges by creating	an unprivileged child	process	to deal	with incoming network traffic.
class ssh::server (
  $package                        = $::ssh::params::server_package,
  $package_ensure                 = $::ssh::params::server_package_ensure,
  $accept_env                     = $::ssh::params::accept_env,
  $address_family                 = $::ssh::params::address_family,
  $allowed_users                  = $::ssh::params::allowed_users,
  $allowed_groups                 = $::ssh::params::allowed_groups,
  $authorized_keys_file           = $::ssh::params::authorized_keys_file,
  $authorized_keys_command        = $::ssh::params::authorized_keys_command,
  $authorized_keys_command_user   = $::ssh::params::authorized_keys_command_user,
  $banner_file                    = $::ssh::params::banner_file,
  $banner_manage                  = $::ssh::params::banner_manage,
  $banner_template                = $::ssh::params::banner_template,
  $compression                    = $::ssh::params::compression,
  $ciphers                        = $::ssh::params::ciphers,
  $client_alive_interval          = $::ssh::params::client_alive_interval,
  $client_alive_count_max         = $::ssh::params::client_alive_count_max,
  $deny_groups                    = $::ssh::params::deny_groups,
  $debian_banner                  = $::ssh::params::debian_banner,
  $gssapi_authentication          = $::ssh::params::gssapi_authentication,
  $gssapi_keyexchange             = $::ssh::params::gssapi_keyexchange,
  $gssapi_cleanupcredentials      = $::ssh::params::gssapi_cleanupcredentials,
  $host_keys                      = $::ssh::params::host_keys,
  $kerberos_authentication        = $::ssh::params::kerberos_authentication,
  $macs                           = $::ssh::params::macs,
  $manage_service                 = $::ssh::params::manage_service,
  $max_auth_retries               = $::ssh::params::max_auth_retries,
  $max_sessions                   = $::ssh::params::max_sessions,
  $max_startups                   = $::ssh::params::max_startups,
  $password_authentication        = $::ssh::params::password_authentication,
  $password_authentication_groups = $::ssh::params::password_authentication_groups,
  $password_authentication_users  = $::ssh::params::password_authentication_users,
  $permit_root_login              = $::ssh::params::permit_root_login,
  $permit_tunnel                  = $::ssh::params::permit_tunnel,
  $permit_tty                     = $::ssh::params::permit_tty,
  $permit_tty_users               = $::ssh::params::permit_tty_users,
  $permit_user_environment        = $::ssh::params::permit_user_environment,
  $port                           = $::ssh::params::port,
  $gateway_ports                  = $::ssh::params::gateway_ports,
  $print_motd                     = $::ssh::params::print_motd,
  $pubkey_authentication          = $::ssh::params::pubkey_authentication,
  $server_key_bits                = $::ssh::params::server_key_bits,
  $service_name                   = $::ssh::params::service_name,
  $subsystem_sftp                 = $::ssh::params::subsystem_sftp,
  $syslog_facility                = $::ssh::params::syslog_facility,
  $syslog_level                   = $::ssh::params::syslog_level,
  $template                       = $::ssh::params::server_config_template,
  $use_dns                        = $::ssh::params::use_dns,
  $use_pam                        = $::ssh::params::use_pam,
  $x11_forwarding                 = $::ssh::params::x11_forwarding,
  $match                          = $::ssh::params::match,
  $kex_algorithms                 = $::ssh::params::kex_algorithms,
  $use_privilege_separation       = $::ssh::params::use_privilege_separation
) inherits ssh::params {
  validate_array(
    $allowed_groups,
    $allowed_users,
    $authorized_keys_file,
    $ciphers,
    $deny_groups,
    $host_keys,
    $kex_algorithms,
    $macs,
    $password_authentication_groups,
    $password_authentication_users,
  )
  validate_bool(
    $banner_manage,
    $manage_service,
  )
  validate_hash(
    $match,
    $permit_tty_users,
  )
  validate_integer([
    $client_alive_count_max,
    $client_alive_interval,
    $max_auth_retries,
    $max_sessions])
  validate_string(
    $accept_env,
    $address_family,
    $authorized_keys_command,
    $authorized_keys_command_user,
    $banner_file,
    $compression,
    $package,
    $package_ensure,
    $port,
    $server_key_bits,
    $service_name,
    $syslog_facility,
    $syslog_level,
    $subsystem_sftp,
  )
  validate_re( $gateway_ports, 'yes|no' )
  validate_re( $gssapi_authentication, 'yes|no' )
  validate_re( $gssapi_cleanupcredentials, 'yes|no' )
  validate_re( $gssapi_keyexchange, 'yes|no' )
  validate_re( $kerberos_authentication, 'yes|no' )
  validate_re( $password_authentication, 'yes|no' )
  validate_re( $permit_root_login, 'yes|no' )
  validate_re( $permit_tunnel, 'yes|no' )
  validate_re( $permit_user_environment, 'yes|no' )
  validate_re( $print_motd, 'yes|no' )
  validate_re( $pubkey_authentication, 'yes|no' )
  validate_re( $use_dns, 'yes|no' )
  validate_re( $use_pam, 'yes|no' )
  validate_re( $x11_forwarding, 'yes|no' )
  validate_re( $use_privilege_separation, 'yes|no|sandbox' )
  if $::osfamily == 'Debian' {
    validate_re( $debian_banner, 'yes|no' )
  }
  if $permit_tty {
    validate_re( $permit_tty, 'yes|no' )
  }

  $match_users = union($password_authentication_users, keys($permit_tty_users))

  package { 'openssh-server':
    ensure => $package_ensure,
    name   => $package,
  } ->
  file { '/etc/ssh/sshd_config':
    content => template($template),
    owner   => root,
    group   => root,
    mode    => '0600'
  }

  if $manage_service {
    service { 'sshd':
      ensure    => running,
      name      => $service_name,
      enable    => true,
      hasstatus => true,
      subscribe => [Package['openssh-server'], File['/etc/ssh/sshd_config']],
      require   => File['/etc/ssh/sshd_config'],
    }
  }

  if $banner_manage {
    file { $banner_file:
      content => template($banner_template),
      require => Package['openssh-server'],
      owner   => root,
      group   => root,
      mode    => '0644'
    }
  }
}
