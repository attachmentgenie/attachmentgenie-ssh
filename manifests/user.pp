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
# @param user (String) User the key belongs to.
define ssh::user (
  $key,
  $comment = undef,
  $ensure  = present,
  $user    = undef,
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
