Puppet SSH Module
=================

Module for configuring SSH.

Tested on Debian GNU/Linux 6.0 Squeeze and Ubuntu 10.4 LTS with
Puppet 2.6. Patches for other operating systems are welcome.


TODO
----

* SSH user config.
* SSH client config.
* SSH server config.


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

Nothing implemented yet.
