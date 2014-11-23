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

# apt repository
apt_repository "newrelic" do
  uri node["new_relic"]["apt_uri"]
  components %w[newrelic non-free]
  key node["new_relic"]["apt_key"]
  keyserver node["new_relic"]["keyserver"]
  only_if { platform_family?("debian") }
end

# yum repository
yum_repository "newrelic" do
  description "New Relic"
  baseurl node["new_relic"]["yum_baseurl"]
  gpgcheck false
  only_if { platform_family?("rhel") }
end

# install the package
package "newrelic-sysmond" do
  options %(-o Dpkg::Options::="--force-confdef") if platform_family?("debian")
end

# ensure the pidfile directory exists
directory File.dirname(node["new_relic"]["pidfile"]) do
  owner "newrelic"
  group "newrelic"
  recursive true
  not_if { node["new_relic"]["pidfile"].empty? }
end

# replace init with upstart on ubuntu
if platform?("ubuntu")
  file "/etc/init.d/newrelic-sysmond" do
    action :delete
  end

  cookbook_file "/etc/init/newrelic-sysmond.conf" do
    owner "root"
    group "root"
  end
end

# setup the main configuration file
template "/etc/newrelic/nrsysmond.cfg" do
  source "nrsysmond.cfg.erb"
  owner "root"
  group "newrelic"
  mode "0640"
  notifies :restart, "service[newrelic-sysmond]"
end

# manage the service
service "newrelic-sysmond" do
  provider Chef::Provider::Service::Upstart if platform?("ubuntu")
  supports status: true, restart: true
  action [:enable, :start]
end
