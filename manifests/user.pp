define ssh::user($ensure=present,
                 $guid,
                 $fullname="",
                 $groups=[],
                 $ssh_comment="",
                 $ssh_key="",
                 $allow_password=false,
                 $shell="/bin/bash") {

  $username = $name

  if $ensure == present {
    Group[$username] -> User[$username] -> File["/home/$username"]
  } else {
    Group[$username] <- File["/home/$username"] -> User[$username]
    Group[$username] <- User[$username]
  }

  group { $username:
    ensure => $ensure,
    allowdupe => false,
    gid => $guid,
  }

  if $allow_password {
    $password = undef
  } else {
    $password = "!"
  }

  user { $username:
    ensure => $ensure,
    allowdupe => false,
    home => "/home/$username",
    managehome => true,
    uid => $guid,
    gid => $guid,
    groups => $groups,
    password => $password,
    shell => $shell,
    comment => $fullname,
  }

  file { "/home/$username":
    ensure => $ensure ? {
      'present' => 'directory',
      default => $ensure,
    },
    owner => $username,
    group => $username,
  }

  if $ssh_key != "" {

    if $ensure == present {
      File["/home/$username"] -> Ssh_authorized_key["${name}@${ssh_comment}"]
    } else {
      Ssh_authorized_key["${name}@${ssh_comment}"] -> User[$username]
      Ssh_authorized_key["${name}@${ssh_comment}"] -> Group[$username]
    }

    ssh_authorized_key { "${name}@${ssh_comment}":
      ensure  => $ensure,
      key => $ssh_key,
      target  => "/home/$username/.ssh/authorized_keys",
      user  => $username,
      type  => "ssh-rsa",
    }
  }
}
