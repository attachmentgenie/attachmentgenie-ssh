# Class to install and configure ssh client.
#
# Use this module to install and configure ssh client.
#
# @example Declaring the class
#   include ::ssh::client
#
# @param ciphers List of ciphers that can be accepted.
# @param enable_ssh_key_sign Enables the use of the helper program ssh-keysign during HostbasedAuthentication.
# @param forward_agent Specifies whether the connection to the authentication agent (if any) will be forwarded to the remote machine.
# @param hostbased_authentication Specifies whether to try rhosts based authentication with public key authentication.
# @param kex_algorithms Key EXchange Algorithms.
# @param known_host_sssd Use sssd to manage known host file.
# @param macs Specifies the MAC (message authentication code) algorithms in order of preference.
# @param package_name Name of package to install.
# @param package_version Version of example to install.
# @param password_authentication Accept access using password.
# @param template Template to use for config.
class ssh::client (
  Array $ciphers = $::ssh::params::ciphers,
  Enum['yes','no'] $enable_ssh_key_sign = $::ssh::params::client_enable_ssh_key_sign,
  Enum['yes','no'] $forward_agent = $::ssh::params::client_forward_agent,
  Enum['yes','no'] $hostbased_authentication = $::ssh::params::client_hostbased_authentication,
  Array $kex_algorithms = $::ssh::params::kex_algorithms,
  Optional[Boolean] $known_host_sssd = $::ssh::params::known_host_sssd,
  Array $macs = $::ssh::params::macs,
  String $package_name = $::ssh::params::client_package,
  String $package_version = $::ssh::params::client_package_version,
  Enum['yes','no'] $password_authentication = $::ssh::params::password_authentication,
  String $template = $::ssh::params::client_config_template,
) inherits ssh::params {
  package { 'openssh-client':
    ensure => $package_version,
    name   => $package_name,
  }
  -> file { '/etc/ssh/ssh_config':
    content => template($template),
    owner   => root,
    group   => root,
    mode    => '0644'
  }
}
