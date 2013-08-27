require 'rubygems'
require 'bundler/setup'

Bundler.require :default

require 'puppetlabs_spec_helper/rake_tasks'
require 'rspec-system/rake_task'
require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.send("disable_80chars")
PuppetLint.configuration.ignore_paths = ["pkg/**/*.pp"]

task :test => [:spec, :lint]

task :default => :test
