type Ssh::PermitRootLogin = Enum[
  'yes',
  'no',
  'prohibit-password',
  'without-password',
  'forced-commands-only' # lint:ignore:trailing_comma
]