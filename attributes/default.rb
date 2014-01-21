#
# Cookbook Name:: newrelic-sysmond
# Attributes:: default
#
# Author:: Phil Cohen <github@phlippers.net>
#
# Copyright 2011-2014, Phil Cohen
#

default["new_relic"]["keyserver"]      = "keyserver.ubuntu.com"
default["new_relic"]["license_key"]    = ""
default["new_relic"]["loglevel"]       = "info"
default["new_relic"]["logfile"]        = "/var/log/newrelic/nrsysmond.log"
default["new_relic"]["proxy"]          = ""
default["new_relic"]["ssl"]            = "false"
default["new_relic"]["ssl_ca_bundle"]  = ""
default["new_relic"]["ssl_ca_path"]    = ""
default["new_relic"]["pidfile"]        = ""
default["new_relic"]["collector_host"] = "collector.newrelic.com"
default["new_relic"]["timeout"]        = 30
