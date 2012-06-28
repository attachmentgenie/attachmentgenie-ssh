[![Build Status](https://secure.travis-ci.org/attachmentgenie/puppet-module-ssh.png)](http://travis-ci.org/attachmentgenie/puppet-module-ssh)

Puppet SSH Module
=================

Module for configuring SSH.

Tested on Debian GNU/Linux 6.0 Squeeze and Ubuntu 10.4 LTS with
Puppet 2.6. Patches for other operating systems are welcome.


Installation
------------

Clone this repo to a ssh directory under your Puppet modules directory:

    git clone git://github.com/uggedal/puppet-module-ssh.git ssh

If you don't have a Puppet Master you can create a manifest file
based on the notes below and run Puppet in stand-alone mode
providing the module directory you cloned this repo to:

    puppet apply --modulepath=modules test_ssh.pp


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

You can use `ssh::user` to add an authorized ssh key to an existing user
for effortless authentication with ssh:

    ssh::user { "uggedal":
      key => "a8a7dgf7ad8j13g",
      comment => "uggedal.com",
    }
