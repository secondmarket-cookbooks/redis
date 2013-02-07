#
# Cookbook Name:: redis
# Recipe:: server
#
# Copyright 2012, SecondMarket Labs, LLC.
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

package_name = "redis"
case node['platform']
when "ubuntu"
    package_name = "redis-server"
end

package package_name do
    action :install
end

service package_name do
  supports :status => true, :restart => true, :reload => false
  action :enable
end

# Fedora uses some systemctl magic here and if you set daemonize to "yes"
# then Redis will automatically get a SIGTERM right after startup
daemonize_value = value_for_platform_family(
                                "fedora"  => "no",
                                "rhel"    => "yes",
                                "default" => "yes"
                                )

template "/etc/redis.conf" do
  source "redis.conf.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  variables(
    :daemonize => daemonize_value
  )
  notifies :restart, "service[#{package_name}]"
  action :create
end

if node['redis']['server']['is_slave']
  if Chef::Config['solo']
      Chef::Log.warn("Configuring redis as a slave requires search for the master. Chef Solo does not support search.")
  else
      redis_master = search(:node, "role:#{node['redis']['server']['master_role']} AND chef_environment:#{node.chef_environment}")

      template "/etc/redis-slave.conf" do
        source "redis-slave.conf.erb"
        owner "root"
        group "root"
        mode "0644"
        variables(
          :redis_master => redis_master.first['fqdn']
          )
        notifies :restart, "service[#{package_name}]"
      end
  end
else
  # Delete the slave config in case it exists, so as not to confuse people
  file "/etc/redis-slave.conf" do
    action :delete
    notifies :restart, "service[#{package_name}]"
  end
end

service package_name do
  action :start
end
