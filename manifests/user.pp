# Class to install and configure ssh keys.
#
# Use this module to install and configure ssh keys.
#
# @example Declaring the class
#   ssh::user {
#     key => 'akalkalkalka',
#   }
#
# @param key (String) Location of flink binary release.
# @param comment (String) Location of flink binary release.
# @param ensure (String) Group that owns flink files.
define ssh::user (
  $key,
  $comment='',
  $ensure=present,
) {

  if $ensure != present {
    Ssh_authorized_key["${name}@${comment}"] -> User[$name]
    Ssh_authorized_key["${name}@${comment}"] -> Group[$name]
  }

  ssh_authorized_key { "${name}@${comment}":
    ensure => $ensure,
    key    => $key,
    user   => $name,
    type   => 'ssh-rsa',
  }
}
