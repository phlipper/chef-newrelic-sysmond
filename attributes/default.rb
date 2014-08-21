#
# Cookbook Name:: newrelic-sysmond
# Attributes:: default
#
# Author:: Phil Cohen <github@phlippers.net>
#
# Copyright 2011-2014, Phil Cohen
#

default["new_relic"]["apt_uri"]        = "http://apt.newrelic.com/debian/"
default["new_relic"]["apt_key"]        = "548C16BF"
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
default["new_relic"]["hostname"]       = ""

# Repository
default["yum"]["new_relic"]["name"] = "newrelic"
default["yum"]["new_relic"]["description"] = "New Relic"
default["yum"]["new_relic"]["baseurl"] = "https://yum.newrelic.com/pub/newrelic/el5/#{node["kernel"]["machine"]}"
