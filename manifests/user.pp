define ssh::user (
  $key,
  $ensure=present,
  $comment=''
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
