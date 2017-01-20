require 'spec_helper'
describe 'ssh::user', :type => :define do
    on_os_under_test.each do |os, facts|
        context "on #{os}" do
            let(:facts) { facts }

            let(:title) { 'foo' }
            let :params do
                {
                    :key  => 'foobarblabbq'
                }
            end
            it { is_expected.to contain_ssh_authorized_key('foo@') }
        end
    end
end
