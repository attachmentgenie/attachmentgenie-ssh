class { 'ssh::client': } ->
class { 'ssh::server':
  allowed_users => ['vagrant'],
}
ssh::user { 'vagrant':
  key => 'foobarblabbq',
}
ssh::user { 'root':
  key => 'foobarblabbq',
}