# Class to install and configure ssh server.
#
# Use this module to install and configure ssh server.
#
# @example The `ssh::server` class installs and configures the sshd
#   class { 'ssh::server':
#     password_authentication => 'yes',
#   }
# @example You can specify the port the sshd should listen to by including the class with this special syntax.
#   class { 'ssh::server':
#     port => 20009,
#   }
# @example You can also restrict access for only certain users.
#   class { 'ssh::server':
#     allowed_users => ['attachmentgenie', 'manager'],
#   }
# @example And you can permit root logins (not recommended) as permiting root logins could be a serious security issue. In most cases you should use something like ```sudo``` instead.
#   class { 'ssh::server':
#     permit_root_login => 'yes',
#   }
#
# @param accept_env Specifies what environment variables sent by the client will be copied into the session's environ.
# @param address_family Specifies which address family should be used by sshd(8).
# @param allow_agent_forwarding Specifies whether ssh-agent forwarding is permitted.
# @param allowed_users If specified, login is allowed only for user names that match one of the patterns.
# @param allowed_groups  If specified, login is allowed only for users whose primary group or supplementary group list matches one of the pattern.
# @param authorized_keys_file Specifies the file that contains the public keys that can be used for user authentication.
# @param authorized_keys_command Specifies a program to be used for lookup of the user's public keys.
# @param authorized_keys_command_user Specifies the user under whose account the AuthorizedKeysCommand is run.
# @param banner_file The contents of the specified file are sent to the remote user before authentication is allowed.
# @param banner_manage Manage the banner file.
# @param banner_template Template to use for banner file.
# @param compression Specifies whether compression is allowed, or delayed until the user has authenticated successfully.
# @param ciphers Specifies the ciphers allowed for protocol version 2.
# @param client_alive_interval Sets a timeout interval in seconds after which if no data has been received from the client.
# @param client_alive_count_max Sets the number of client alive messages (see below) which may be sent without sshd(8) receiving any messages back from the client.
# @param deny_groups Login is disallowed for users whose primary group or supplementary group list matches one of the patterns.
# @param debian_banner Specifies whether the distribution-specified extra version suffix is included during initial protocol handshake.
# @param gssapi_authentication Specifies whether user authentication based on GSSAPI is allowed.
# @param gssapi_keyexchange Specifies whether key exchange based on GSSAPI is allowed.
# @param gssapi_cleanupcredentials Specifies whether to automatically destroy the user's credentials cache on logout.
# @param host_keys Specifies a file containing a private host key used by SSH.
# @param kerberos_authentication Specifies whether the password provided by the user for PasswordAuthentication will be validated through the Kerberos KDC.
# @param kex_algorithms Specifies the available KEX (Key Exchange)	algorithms.
# @param macs Specifies the available MAC (message authentication code) algorithms.
# @param manage_service Manage sshd service.
# @param match # @param password_authentication_users Introduces a conditional block. If all of the criteria on the Match line are satisfied, the keywords on the following lines override those set in the global section of the config file, until either another Match line or the end of the file.
# @param max_auth_retries Specifies the maximum number of authentication attempts permitted per connection.
# @param max_sessions Specifies the maximum number of open sessions permitted per network connection.
# @param max_startups Specifies the maximum number of concurrent unauthenticated connections to the SSH daemon.
# @param package Package name.
# @param package_version Standard puppet package ensure.
# @param password_authentication Specifies whether password authentication is allowed.
# @param password_authentication_groups Introduces a conditional block. If all of the criteria on the Match line are satisfied, the keywords on the following lines override those set in the global section of the config file, until either another Match line or the end of the file.
# @param password_authentication_users Introduces a conditional block. If all of the criteria on the Match line are satisfied, the keywords on the following lines override those set in the global section of the config file, until either another Match line or the end of the file.
# @param permit_root_login Specifies whether root can log in using ssh.
# @param permit_tunnel Specifies whether tun(4) device forwarding is allowed.
# @param permit_tty Specifies whether pty(4) allocation is permitted.
# @param permit_tty_users Introduces a conditional block. If all of the criteria on the Match line are satisfied, the keywords on the following lines override those set in the global section of the config file, until either another Match line or the end of the file.
# @param permit_user_environment Specifies whether ~/.ssh/environment and environment= options in ~/.ssh/authorized_keys are	processed by sshd.
# @param port Specifies the port	number that sshd listens on.
# @param gateway_ports Specifies whether remote hosts are	allowed	to connect to ports forwarded for the client.
# @param print_motd Specifies whether sshd(8) should print /etc/motd when a user logs in	interactively.
# @param pubkey_authentication Specifies whether public key authentication is allowed.
# @param server_key_bits Defines the number	of bits	in the ephemeral protocol version 1 server key.
# @param service_name Ssh service name.
# @param subsystem_sftp Configures	an external subsystem for sftp.
# @param syslog_facility Gives the facility	code that is used when logging messages	from sshd.
# @param syslog_level Gives the verbosity level that is used when logging messages from sshd.
# @param template Template to use for config.
# @param use_dns pecifies whether sshd(8) should look up the remote host name, and to check that the resolved host name for the remote IP address maps back to the very same	IP address.
# @param use_pam Enables the Pluggable Authentication Module interface.
# @param use_privilege_separation Specifies whether sshd(8) separates privileges by creating	an unprivileged child	process	to deal	with incoming network traffic.
# @param x11_forwarding Specifies whether X11 forwarding is permitted.
class ssh::server (
  String $accept_env = $::ssh::params::accept_env,
  String $address_family = $::ssh::params::address_family,
  Ssh::YesNo $allow_agent_forwarding = $::ssh::params::allow_agent_forwarding,
  Array $allowed_users = $::ssh::params::allowed_users,
  Array $allowed_groups = $::ssh::params::allowed_groups,
  Array $authorized_keys_file = $::ssh::params::authorized_keys_file,
  Optional[String] $authorized_keys_command = $::ssh::params::authorized_keys_command,
  Optional[String] $authorized_keys_command_user = $::ssh::params::authorized_keys_command_user,
  String $banner_file = $::ssh::params::banner_file,
  Boolean $banner_manage = $::ssh::params::banner_manage,
  String $banner_template = $::ssh::params::banner_template,
  Optional[String] $compression = $::ssh::params::compression,
  Array $ciphers = $::ssh::params::ciphers,
  Integer $client_alive_interval = $::ssh::params::client_alive_interval,
  Integer $client_alive_count_max = $::ssh::params::client_alive_count_max,
  Array $deny_groups = $::ssh::params::deny_groups,
  Optional[Ssh::YesNo] $debian_banner = $::ssh::params::debian_banner,
  Ssh::YesNo $gateway_ports = $::ssh::params::gateway_ports,
  Ssh::YesNo $gssapi_authentication = $::ssh::params::gssapi_authentication,
  Ssh::YesNo $gssapi_keyexchange = $::ssh::params::gssapi_keyexchange,
  Ssh::YesNo $gssapi_cleanupcredentials = $::ssh::params::gssapi_cleanupcredentials,
  Array $host_keys = $::ssh::params::host_keys,
  Ssh::YesNo $kerberos_authentication = $::ssh::params::kerberos_authentication,
  Array $kex_algorithms = $::ssh::params::kex_algorithms,
  Array $macs = $::ssh::params::macs,
  Boolean $manage_service = $::ssh::params::manage_service,
  Hash $match = $::ssh::params::match,
  Integer $max_auth_retries = $::ssh::params::max_auth_retries,
  Integer $max_sessions = $::ssh::params::max_sessions,
  String $max_startups = $::ssh::params::max_startups,
  String $package = $::ssh::params::server_package,
  String $package_version = $::ssh::params::server_package_version,
  Ssh::YesNo $password_authentication = $::ssh::params::password_authentication,
  Array $password_authentication_groups = $::ssh::params::password_authentication_groups,
  Array $password_authentication_users = $::ssh::params::password_authentication_users,
  Ssh::PermitRootLogin $permit_root_login = $::ssh::params::permit_root_login,
  Ssh::YesNo $permit_tunnel = $::ssh::params::permit_tunnel,
  Optional[Ssh::YesNo] $permit_tty = $::ssh::params::permit_tty,
  Hash $permit_tty_users = $::ssh::params::permit_tty_users,
  Ssh::YesNo $permit_user_environment = $::ssh::params::permit_user_environment,
  String $port = $::ssh::params::port,
  Ssh::YesNo $print_motd = $::ssh::params::print_motd,
  Ssh::YesNo $pubkey_authentication = $::ssh::params::pubkey_authentication,
  String $server_key_bits = $::ssh::params::server_key_bits,
  String $service_name = $::ssh::params::service_name,
  String $subsystem_sftp = $::ssh::params::subsystem_sftp,
  String $syslog_facility = $::ssh::params::syslog_facility,
  String $syslog_level = $::ssh::params::syslog_level,
  String $template = $::ssh::params::server_config_template,
  Ssh::YesNo $use_dns = $::ssh::params::use_dns,
  Ssh::YesNo $use_pam = $::ssh::params::use_pam,
  Ssh::UsePrivilegeSeparation $use_privilege_separation = $::ssh::params::use_privilege_separation,
  Ssh::YesNo $x11_forwarding = $::ssh::params::x11_forwarding,
) inherits ssh::params {
  $match_users = union($password_authentication_users, keys($permit_tty_users))

  package { 'openssh-server':
    ensure => $package_version,
    name   => $package,
  }
  -> file { '/etc/ssh/sshd_config':
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
