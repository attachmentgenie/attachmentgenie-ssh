[![Build Status](https://secure.travis-ci.org/attachmentgenie/attachmentgenie-ssh.png)](http://travis-ci.org/attachmentgenie/attachmentgenie-ssh)

#attachmentgenie/ssh

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with attachmentgenie/ssh](#setup)
    * [What attachmentgenie/ssh affects](#what-attachmentgenie/ssh-affects)
    * [Beginning with attachmentgenie/ssh](#beginning-with-attachmentgenie/ssh)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

Module for configuring ssh on your Centos, Debian, Redhat, Ubuntu node.

##Module Description

The module makes it possible to install a ssh server and/or client and to add authorized ssh keys to existing users.

##Setup

###What attachmentgenie/ssh affects

* ssh server
* ssh client
* add authorized ssh keys to existing users.

###Beginning with attachmentgenie/ssh	

The `ssh::client` class installs the ssh client:

    class { 'ssh::client': }

The `ssh::server` class installs and configures the sshd:

    class { 'ssh::server': }
    
##Usage

You can specify the port the sshd should listen to by including the class
with this special syntax:

    class { 'ssh::server':
      port => 20009,
    }

You can also restrict access for only certain users:

    class { 'ssh::server':
      allowed_users => ['uggedal', 'manager'],
    }

And you can permit root logins (not recommended):
    
    class { 'ssh::server':
      permit_root_login => 'yes',
    }
    
To permit root logins could be a serious security issue. In most cases you should
use something like ```sudo``` instead.

You can use `ssh::user` to add an authorized ssh key to an existing user
for effortless authentication with ssh:

    ssh::user { 'uggedal':
      key => 'a8a7dgf7ad8j13g',
      comment => 'uggedal.com',
    }

##Reference

###Classes

####Public Classes

* ssh:         Class is not used and will throw a notice.
* ssh::server: Class that installs and configures a ssh server.
* ssh::client: Class that installs and configures a ssh client.
* ssh::user:   Class to add ssh keys to existing users.

###Parameters

The following parameters are available in the `ssh::server` class:

####`zone`

Set what ssh to use on this node. Default value: 'UTC'
####`port`

Default value:22',

####`allowed_users`

Default value:[],

####`allowed_groups`

Default value:[],

####`password_authentication_groups`

Default value:[],

####`password_authentication_users`

Default value:[],

####`x11_forwarding`

Default value:no',

####`use_dns`

Default value:yes',

####`password_authentication`

Default value:no',

####`pubkey_authentication`

Default value:yes',

####`subsystem_sftp`

Default value:/usr/lib/openssh/sftp-server',

####`use_pam`

Default value:yes',

####`permit_root_login`

Default value:no',

####`print_motd `

Default value: $ssh::params::print_motd,

####`host_keys`

Default value:$ssh::params::host_keys,

####`manage_service`

Default value:true,

####`ServerKeyBits`

Default value:1024,

####`banner`

Default value:/etc/issue.net',

####`ciphers`

Default value:[],

####`macs`

Default value:[],

####`client_alive_interval`

Default value:undef,

####`client_alive_count_max`

Default value:undef,

####`template`

Default value:ssh/sshd_config.erb',

####`accept_env`

Default value:LANG LC_*'

The following parameters are available in the `ssh::server` class:

####`key`

ssh key to add to user.

####`ensure`

Default value: present

####`comment`

Comment to add to the ssh key. Default value: ''

##Limitations

Currently there are no know limitations

##Development

Please see [CONTRIBUTING](https://github.com/attachmentgenie/attachmentgenie-ssh/blob/master/CONTRIBUTING.md) for details.
