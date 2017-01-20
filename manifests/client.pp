# Class to install and configure ssh client.
#
# Use this module to install and configure ssh client.
#
# @example Declaring the class
#   include ::ssh::client
#
# @param ciphers (Array) List of ciphers that can be accepted.
# @param enable_ssh_key_sign (String) Enables the use of the helper program ssh-keysign during HostbasedAuthentication.
# @param forward_agent (String) Specifies whether the connection to the authentication agent (if any) will be forwarded to the remote machine.
# @param hostbased_authentication (String) Specifies whether to try rhosts based authentication with public key authentication.
# @param kex_algorithms (Array) Key EXchange Algorithms.
# @param known_host_sssd Use sssd to manage known host file.
# @param macs (Array) Specifies the MAC (message authentication code) algorithms in order of preference.
# @param package_name (String) Package name.
# @param package_ensure (String) Standard puppet package ensure.
# @param password_authentication (String) Accept access using password.
# @param template (String) Template to use for config.
class ssh::client (
  $ciphers                  = $::ssh::params::ciphers,
  $enable_ssh_key_sign      = $::ssh::params::client_enable_ssh_key_sign,
  $forward_agent            = $::ssh::params::client_forward_agent,
  $hostbased_authentication = $::ssh::params::client_hostbased_authentication,
  $kex_algorithms           = $::ssh::params::kex_algorithms,
  $known_host_sssd          = $::ssh::params::known_host_sssd,
  $macs                     = $::ssh::params::macs,
  $package_name             = $::ssh::params::client_package,
  $package_ensure           = $::ssh::params::client_package_ensure,
  $password_authentication  = $::ssh::params::password_authentication,
  $template                 = $::ssh::params::client_config_template,
) inherits ssh::params {
  if $known_host_sssd {
    validate_bool(
      $known_host_sssd,
    )
  }
  validate_array(
    $ciphers,
    $kex_algorithms,
    $macs,
  )
  validate_string(
    $package_name,
    $package_ensure,
    $template,
  )
  validate_re( $enable_ssh_key_sign, 'yes|no' )
  validate_re( $forward_agent, 'yes|no' )
  validate_re( $hostbased_authentication, 'yes|no' )
  validate_re( $password_authentication, 'yes|no' )

  package { 'openssh-client':
    ensure => $package_ensure,
    name   => $package_name,
  } ->
  file { '/etc/ssh/ssh_config':
    content => template($template),
    owner   => root,
    group   => root,
    mode    => '0644'
  }
}
