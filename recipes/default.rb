#
# Cookbook Name:: newrelic-sysmond
# Recipe:: default
#
# Copyright 2011-2014, Phil Cohen
#

if node["new_relic"]["license_key"].empty?
  warning = <<-EOM
The `newrelic-sysmond` recipe was included, but a licence key was not provided.
Please set `node["new_relic"]["license_key"]` to avoid this warning.
EOM

  log warning do
    level :warn
  end

  return
end

if platform_family?("debian")
  apt_repository "newrelic" do
    uri node["new_relic"]["apt_uri"]
    components %w[newrelic non-free]
    key node["new_relic"]["apt_key"]
    keyserver node["new_relic"]["keyserver"]
  end
elsif platform_family?("rhel")
  yum_repository node["yum"]["new_relic"]["name"] do
    description node["yum"]["new_relic"]["description"]
    baseurl node["yum"]["new_relic"]["baseurl"]
    gpgcheck false
  end
end

package "newrelic-sysmond"

template "/etc/newrelic/nrsysmond.cfg" do
  source "nrsysmond.cfg.erb"
  owner "root"
  group "newrelic"
  mode "0640"
  notifies :restart, "service[newrelic-sysmond]"
end

service "newrelic-sysmond" do
  action [:enable, :start]
end
