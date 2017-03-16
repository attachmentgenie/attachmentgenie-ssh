# 16-03-2017 - Release 2.1.0
- Allowing users to have multiple authorized keys (#51)

# 17-01-2017 - Release 2.0.0

- Adding more parameters to/for ssh_config
    - ciphers
    - kex_algorithms
    - macs
    - password_authentication
- Adding more parameters to/for sshd_config
    - package
    - compression
    - deny_groups
    - gssapi_keyexchange
    - gssapi_cleanupcredentials
    - kerberos_authentication
    - max_sessions
    - max_startups
    - port
    - kex_algorithms
    - use_privilege_separation
- Moving to test kitchen for integration testing
- Now implementing dev-sec.io ssh hardening standard version 2.1.1 (https ://github.com/dev-sec/ssh-baseline)

## Backward incompatible changes
- Support for puppet 3 has been dropped.
- Support for non LTS releases is no longer guaranteed.
- Support is only guaranteed for the last 2 LTS versions (if applicable).
- In order to pass the dev-sec.io ssh hardening standard several parameters/ssh_config defaults have been changed.
    - PasswordAuthentication : system default => no
    - GSSAPIAuthentication : system default => no
    - Protocol : system default => 2
    - Ciphers : system default => see params.pp
    - KexAlgorithms : system default => see params.pp
    - MACs : system default => see params.pp
- In order to pass the dev-sec.io ssh hardening standard several parameters/sshd_config defaults have been changed.
    - AllowAgentForwarding : system default => no
    - AllowTcpForwarding : system default => no
    - AddressFamily : system default => any
    - ListenAddress : system default => 0.0.0.0
    - Banner : system defaukt => none
    - UsePrivilegeSeparation : yes => see params.pp
    - KexAlgorithms : system default => see params.pp
    - LoginGraceTime : 120 => 30s
    - IgnoreUserKnownHosts : system default => yes
    - KerberosAuthentication : system default => no
    - KerberosOrLocalPasswd : system default => no
    - KerberosTicketCleanup : system default => yes
    - GSSAPIKeyExchange : system default => no
    - GSSAPICleanupCredentials : system default => yes
    - X11UseLocalhost : system default => yes
    - PrintLastLog : yes => no
    - TCPKeepAlive : yes => no
    - UseLogin : system default => no
    - Compression : system default => undef
    - MaxStartups : system default => 10:30:100
    - MaxAuthTries : 6 => 2
    - MaxSessions : system default => 10

# 27-05-2016 - Release 1.6.0
### Summary
- Updating module layout
- Adding code to manage ssh_config
- Adding more parameters to manage in sshd_config
- Adding integration testing
