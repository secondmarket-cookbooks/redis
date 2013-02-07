Description
===========

Installs [Redis](http://redis.io/), an advanced key-value store whose keys can be strings, hashes, lists, sets and sorted sets.

Requirements
============

## Platforms

* CentOS 5.x, 6.x
* Red Hat Enterprise Linux 5.x, 6.x
* Ubuntu 12.04.1 (Precise)

Tested with Redis 2.4.x on CentOS/Red Hat Enterpise, and Redis 2.2.x on Ubuntu.

## Cookbooks

* yum

Redis lives within the EPEL repository, so you'll need to include yum::epel in your run list. (It seems to be a matter of debate whether or not cookbook authors should `include_recipe` this -- I haven't, at least for now.)

Attributes
==========

Global options
--------------

* `['redis']['server']['bind_address']` - what address to bind to (default 127.0.0.1; set to 0.0.0.0 if you're connecting to Redis from another server)
* `['redis']['server']['idle_timeout']` - idle timeout
* `['redis']['server']['log_level']` - what log level should the Redis server log at
* `['redis']['server']['datadir']` - where RDB or AOF format snapshots/data files will live

RDB format snapshots
--------------------

* `['redis']['server']['snapshotting']` - whether to generate RDB format snapshots; false by default
* `['redis']['server']['snapshot_compression']` - whether to compress RDB format snapshots; true by default
* `['redis']['server']['snapshot_file']` - name of the snapshot file, 'dump.rdb' by default
* `['redis']['server']['snapshot_intervals']` - an array of snapshot policies, each element of which is a policy. Will save the DB if both the given number of seconds (the first element) and the given number of write operations (the second element) against the DB occurred.

Master-Slave
------------

Note that the slave finds the master using Search, so this doesn't work in Chef Solo.

* `['redis']['server']['is_slave']` - whether to operate this instance as a slave.
* `['redis']['server']['master_role']` - name of the role to search for, to find the master.

AOF (Append-Only File) Format Snapshots
---------------------------------------

* `['redis']['server']['appendonly']` - whether to generate AOF-format snapshots; default is false.
* `['redis']['server']['aof_file']` - name of the AOF file, 'appendonly.aof' by default
* `['redis']['server']['fsync_style']` - when to fsync() the file; 'everysec' by default

Recipes
=======

default
-------

Does nothing.

server
------

Installs Redis from EPEL packages and optionally configures it as a slave if you have set the `['redis']['server']['is_slave']` attribute.

Limitations
===========

* Not every parameter is configurable in redis.conf.
* Slave search logic assumes that you're using Chef environments and that the master resides in the same environment.

License and Author
==================

Author:: Julian C. Dunn <jdunn@secondmarket.com>
Copyright:: 2012-2013 SecondMarket Labs, LLC.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
