define ssh::user($guid,
                 $fullname="",
                 $groups=[],
                 $ssh_comment="",
                 $ssh_key="",
                 $allow_password=false,
                 $shell="/bin/bash") {

  $username = $name

  group { $username:
    ensure => present,
    allowdupe => false,
    gid => $guid,
  }

  if $allow_password {
    $password = undef
  } else {
    $password = "!"
  }

  user { $username:
    ensure => present,
    allowdupe => false,
    home => "/home/$username",
    managehome => true,
    uid => $guid,
    gid => $guid,
    groups => $groups,
    password => $password,
    shell => $shell,
    comment => $fullname,
    require => Group[$username],
  }

  file { "/home/$username":
    ensure => directory,
    owner => $username,
    group => $username,
    require => User[$username],
  }

  if $ssh_key != "" {
    ssh_authorized_key { "${name}@${ssh_comment}":
      ensure  => "present",
      key => $ssh_key,
      target  => "/home/$username/.ssh/authorized_keys",
      user  => $username,
      type  => "ssh-rsa",
      require => File["/home/$username"],
    }
  }
}
