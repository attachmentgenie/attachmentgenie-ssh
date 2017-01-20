require 'spec_helper'
describe 'ssh::params' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context "It should not contain any resources" do
        it { should contain_class('ssh::params') }
        it { should have_resource_count(0) }
      end
    end
  end
end