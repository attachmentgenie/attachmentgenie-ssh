class { 'ssh::client': }
-> class { 'ssh::server':
  allowed_users => ['vagrant'],
}
