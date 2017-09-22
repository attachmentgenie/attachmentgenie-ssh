# Class to install and configure ssh keys.
#
# Use this module to install and configure ssh keys.
#
# @example Declaring the class
#   ssh::user {
#     key => 'akalkalkalka',
#   }
#
# @param key public key to trust.
# @param comment Comment to save with public key.
# @param ensure Ensure public key.
# @param user User the key belongs to.
define ssh::user (
  String $key,
  Optional[String] $comment = undef,
  String $ensure = present,
  Optional[String] $user = undef,
) {

  if $comment {
    $identifier = $comment
  }  else {
    if $user {
      $identifier = $name
    } else {
      $identifier = ''
    }
  }

  if $ensure != present {
    Ssh_authorized_key["${username}@${identifier}"] -> User[$username]
    Ssh_authorized_key["${username}@${identifier}"] -> Group[$username]
  }

  if $user {
    $username = $user
  } else {
    $username = $name
  }

  ssh_authorized_key { "${username}@${identifier}":
    ensure => $ensure,
    key    => $key,
    user   => $username,
    type   => 'ssh-rsa',
  }
}
