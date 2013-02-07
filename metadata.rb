name              "redis"
maintainer        "SecondMarket Labs, LLC"
maintainer_email  "systems@secondmarket.com"
license           "Apache 2.0"
description       "Installs and configures Redis server."
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.3.4"
recipe            "redis", "Does nothing."
recipe            "redis::server", "Installs redis server."

%w{ centos fedora redhat ubuntu }.each do |os|
  supports os
end
