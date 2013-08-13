[![Build Status](https://secure.travis-ci.org/attachmentgenie/puppet-module-ssh.png)](http://travis-ci.org/attachmentgenie/puppet-module-ssh)

Puppet SSH Module
=================

Module for configuring ssh.

Tested on Debian GNU/Linux 6.0 Squeeze and Ubuntu 10.4 LTS and 12.04 LTS with
Puppet 2.6 and 2.7. Patches for other operating systems are welcome.

Usage
-----

The `ssh::client` class installs the ssh client:

    include ssh::client

The `ssh::server` class installs and configures the sshd:

    include ssh::server

You can specify the port the sshd should listen to by including the class
with this special syntax:

    class { "ssh::server":
      port => 20009,
    }

You can also restrict access for only certain users:

    class { "ssh::server":
      allowed_users => ["uggedal", "manager"],
    }

And you can permit root logins (not recommended):
    
    class { "ssh::server":
      permit_root_login => 'yes',
    }
    
To permit root logins could be a serious security issue. In most cases you should
use something like ```sudo``` instead.

You can use `ssh::user` to add an authorized ssh key to an existing user
for effortless authentication with ssh:

    ssh::user { "uggedal":
      key => "a8a7dgf7ad8j13g",
      comment => "uggedal.com",
    }
