#
# Author:: Julian Dunn (<jdunn@secondmarket.com>)
# Cookbook Name:: redis
# Attribute:: default
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

default['redis']['server']['bind_address']  = '127.0.0.1'
default['redis']['server']['idle_timeout']  = 0
default['redis']['server']['log_level']     = 'notice'

default['redis']['server']['datadir']       = '/var/lib/redis'

# RDB-format snapshots
default['redis']['server']['snapshotting']  = false
default['redis']['server']['snapshot_compression'] = true
default['redis']['server']['snapshot_file'] = 'dump.rdb'
default['redis']['server']['snapshot_intervals'] = [ [ 900, 1 ], [ 300, 10 ], [ 60, 10000 ] ]

# Setup of master-slave relationship if applicable. The recipe will search for nodes in the current environment with master_role if so.
default['redis']['server']['is_slave']      = false
default['redis']['server']['master_role']   = 'redis-master'

# AOF-format datasets (it IS compatible with RDB)
default['redis']['server']['appendonly']    = false
default['redis']['server']['aof_file']      = 'appendonly.aof'
default['redis']['server']['fsync_style']   = 'everysec' # or "always", or "no"
