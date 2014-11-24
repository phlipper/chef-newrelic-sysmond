#
# Cookbook Name:: newrelic-sysmond
# Attributes:: default
#
# Author:: Phil Cohen <github@phlippers.net>
#
# Copyright 2011-2014, Phil Cohen
#

default["newrelic-sysmond"]["apt_uri"]        = "http://apt.newrelic.com/debian/"
default["newrelic-sysmond"]["apt_key"]        = "548C16BF"
default["newrelic-sysmond"]["keyserver"]      = "hkp://keyserver.ubuntu.com:80"
default["newrelic-sysmond"]["yum_baseurl"]    = "https://yum.newrelic.com/pub/newrelic/el5/#{node["kernel"]["machine"]}"
default["newrelic-sysmond"]["license_key"]    = ""
default["newrelic-sysmond"]["loglevel"]       = "info"
default["newrelic-sysmond"]["logfile"]        = "/var/log/newrelic/nrsysmond.log"
default["newrelic-sysmond"]["proxy"]          = ""
default["newrelic-sysmond"]["ssl"]            = "true"
default["newrelic-sysmond"]["ssl_ca_bundle"]  = ""
default["newrelic-sysmond"]["ssl_ca_path"]    = ""
default["newrelic-sysmond"]["pidfile"]        = "/var/run/newrelic/nrsysmond.pid"
default["newrelic-sysmond"]["collector_host"] = "collector.newrelic.com"
default["newrelic-sysmond"]["timeout"]        = 30
default["newrelic-sysmond"]["hostname"]       = ""
default["newrelic-sysmond"]["labels"]         = ""
