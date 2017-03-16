require 'spec_helper'
describe 'ssh::user', :type => :define do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'add a key for user foo using name parameter' do
        let(:title) { 'foo' }
        let :params do
          {
            :key  => 'bar',
          }
        end
        it { is_expected.to contain_ssh_authorized_key('foo@').with(
          'key' => 'bar',
        ) }
      end

      context 'add a key for user foo using name parameter' do
        let(:title) { 'foo' }
        let :params do
          {
            :comment => 'bla',
            :key  => 'bar',
          }
        end
        it { is_expected.to contain_ssh_authorized_key('foo@bla').with(
            'key' => 'bar',
        ) }
      end

      context 'add a key for user foo by user parameter' do
        let(:title) { 'bbq' }
        let :params do
          {
            :key  => 'bar',
            :user => 'foo'
          }
        end
        it { is_expected.to contain_ssh_authorized_key('foo@bbq').with(
          'key' => 'bar',
        ) }
      end
    end
  end
end
