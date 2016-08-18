require 'spec_helper'

describe 'ssh::user', :type => :define do
    let(:title) { 'foo' }
    let :params do
    {
        :key  => 'foobarblabbq'
    }
    end
    it { is_expected.to contain_ssh_authorized_key('foo@') }
end
