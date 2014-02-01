#
# Cookbook Name:: fail2ban
# Recipe:: default
#
# Copyright 2009-2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# epel repository is needed for the fail2ban package on rhel
include_recipe 'yum-epel' if platform_family?('rhel')

package 'fail2ban' do
  action :upgrade
end


cookbook_file "/etc/fail2ban/filter.d/proxy.conf" do
  source "proxy.conf"
  owner  "root"
  group  "root"
  mode   "0644"
end

cookbook_file "/etc/fail2ban/filter.d/nginx-noscript.conf" do
  source "nginx-noscript.conf"
  owner  "root"
  group  "root"
  mode   "0644"
end

cookbook_file "/etc/fail2ban/filter.d/nginx-auth.conf" do
  source "nginx-auth.conf"
  owner  "root"
  group  "root"
  mode   "0644"
end

cookbook_file "/etc/fail2ban/filter.d/nginx-login.conf" do
  source "nginx-login.conf"
  owner  "root"
  group  "root"
  mode   "0644"
end

cookbook_file "/etc/fail2ban/filter.d/w00tw00t.conf" do
  source "w00tw00t.conf"
  owner  "root"
  group  "root"
  mode   "0644"
end

# Add the test script
cookbook_file "/etc/fail2ban/test_bans.sh" do
  source "test_bans.sh"
  owner  "root"
  group  "root"
  mode   "0644"
end

# Add the test script
cookbook_file "/etc/fail2ban/example.log" do
  source "example.log"
  owner  "root"
  group  "root"
  mode   "0644"
end


template '/etc/fail2ban/fail2ban.conf' do
  source 'fail2ban.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[fail2ban]'
end

template '/etc/fail2ban/jail.local' do
  source 'jail.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[fail2ban]'
end

service 'fail2ban' do
  supports [:status => true, :restart => true]
  action [:enable, :start]

  if (platform?('ubuntu') && node['platform_version'].to_f < 12.04) ||
      (platform?('debian') && node['platform_version'].to_f < 7)
    # status command returns non-0 value only since fail2ban 0.8.6-3 (Debian)
    status_command "/etc/init.d/fail2ban status | grep -q 'is running'"
  end
end
