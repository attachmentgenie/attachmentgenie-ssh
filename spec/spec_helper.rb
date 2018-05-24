
require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'

begin
  require 'spec_helper_local' if File.file?(File.join(File.dirname(__FILE__), 'spec_helper_local.rb'))
rescue LoadError => loaderror
  warn "Could not require spec_helper_local: #{loaderror.message}"
end

include RspecPuppetFacts

default_facts = {
  puppetversion: Puppet.version,
  facterversion: Facter.version,
}

default_facts_path = File.expand_path(File.join(File.dirname(__FILE__), 'default_facts.yml'))
default_module_facts_path = File.expand_path(File.join(File.dirname(__FILE__), 'default_module_facts.yml'))

if File.exist?(default_facts_path) && File.readable?(default_facts_path)
  default_facts.merge!(YAML.safe_load(File.read(default_facts_path)))
end

if File.exist?(default_module_facts_path) && File.readable?(default_module_facts_path)
  default_facts.merge!(YAML.safe_load(File.read(default_module_facts_path)))
end

# Running tests with the ONLY_OS environment variable set
# limits the tested platforms to the specified values.
# Example: ONLY_OS=centos-7-x86_64,ubuntu-14-x86_64
def only_test_os
  ENV['ONLY_OS'].split(',') if ENV.key?('ONLY_OS')
end

# Running tests with the EXCLUDE_OS environment variable set
# limits the tested platforms to all but the specified values.
# Example: EXCLUDE_OS=centos-7-x86_64,ubuntu-14-x86_64
def exclude_test_os
  ENV['EXCLUDE_OS'].split(',') if ENV.key?('EXCLUDE_OS')
end

# Use the above environment variables to limit the platforms under test
def on_os_under_test
  on_supported_os.reject do |os, _facts|
    (only_test_os && !only_test_os.include?(os)) ||
      (exclude_test_os && exclude_test_os.include?(os))
  end
end

RSpec.configure do |c|
  c.default_facts = default_facts
  c.before :each do
    # set to strictest setting for testing
    # by default Puppet runs at warning level
    Puppet.settings[:strict] = :warning
  end
end
