[![Build Status](https://secure.travis-ci.org/attachmentgenie/attachmentgenie-ssh.png)](http://travis-ci.org/attachmentgenie/attachmentgenie-ssh)

#attachmentgenie/ssh

####Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with attachmentgenie/ssh](#setup)
    * [What attachmentgenie/ssh affects](#what-attachmentgenie/ssh-affects)
    * [Beginning with attachmentgenie/ssh](#beginning-with-attachmentgenie/ssh)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Development - Guide for contributing to the module](#development)

##Overview

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

    class { 'ssh::server':
      password_authentication => 'yes',
    }
    
##Usage

You can specify the port the sshd should listen to by including the class
with this special syntax:

    class { 'ssh::server':
      port => 20009,
    }

You can also restrict access for only certain users:

    class { 'ssh::server':
      allowed_users => ['attachmentgenie', 'manager'],
    }

And you can permit root logins (not recommended):
    
    class { 'ssh::server':
      permit_root_login => 'yes',
    }
    
To permit root logins could be a serious security issue. In most cases you should
use something like ```sudo``` instead.

You can use `ssh::user` to add an authorized ssh key to an existing user
for effortless authentication with ssh:

    ssh::user { 'attachmentgenie':
      key     => 'a8a7dgf7ad8j13g',
      comment => 'laptop',
    }

    ssh::user { 'laptop':
      key  => 'a8a7dgf7ad8j13g',
      user => 'attachmentgenie',
    }
##Development

Please see [CONTRIBUTING](https://github.com/attachmentgenie/attachmentgenie-ssh/blob/master/CONTRIBUTING.md) for details.
