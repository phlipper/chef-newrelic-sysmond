name             "newrelic-sysmond"
maintainer       "Phil Cohen"
maintainer_email "github@phlippers.net"
license          "MIT"
description      "Setup New Relic sysmond for server monitoring"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "1.3.0"

recipe "newrelic-sysmond", "Install and configure newrelic-sysmond"

supports "debian"
supports "ubuntu"
