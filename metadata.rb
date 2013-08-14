name             "newrelic-sysmond"
maintainer       "Phil Cohen"
maintainer_email "github@phlippers.net"
license          "MIT"
description      "Setup New Relic sysmond for server monitoring"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "1.3.2"

recipe "newrelic-sysmond", "Install and configure newrelic-sysmond"

depends 'apt', '>= 1.9.2'

supports "debian"
supports "ubuntu"
supports "redhat", ">= 5.0"
supports "centos", ">= 5.0"
