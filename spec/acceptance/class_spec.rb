# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'with default parameters ', if: ['debian', 'redhat', 'ubuntu'].include?(os[:family]) do
  pp = <<-PUPPETCODE
  class { 'ssh::client': }
  -> class { 'ssh::server':
    allowed_users => ['vagrant'],
  }
PUPPETCODE

  it 'applies idempotently' do
    idempotent_apply(pp)
  end
  
  describe file('/home/vagrant/.ssh/authorized_keys') do
    it { is_expected.to be_file }
  end
end
