#
# Cookbook Name:: newrelic-sysmond
# Recipe:: default
#
# Copyright 2011-2014, Phil Cohen
#

if node["newrelic-sysmond"]["license_key"].empty?
  warning = <<-EOM
The `newrelic-sysmond` recipe was included, but a licence key was not provided.
Please set `node["newrelic-sysmond"]["license_key"]` to avoid this warning.
EOM

  log warning do
    level :warn
  end

  return
end

# apt repository
apt_repository "newrelic" do
  uri node["newrelic-sysmond"]["apt_uri"]
  components %w[newrelic non-free]
  key node["newrelic-sysmond"]["apt_key"]
  keyserver node["newrelic-sysmond"]["keyserver"]
  only_if { platform_family?("debian") }
end

# yum repository
yum_repository "newrelic" do
  description "New Relic"
  baseurl node["newrelic-sysmond"]["yum_baseurl"]
  gpgcheck false
  only_if { platform_family?("rhel") }
end

# install the package
package "newrelic-sysmond" do
  options %(-o Dpkg::Options::="--force-confdef") if platform_family?("debian")
end

# ensure the pidfile directory exists
directory File.dirname(node["newrelic-sysmond"]["pidfile"]) do
  owner "newrelic"
  group "newrelic"
  recursive true
  not_if { node["newrelic-sysmond"]["pidfile"].empty? }
end

# replace init with upstart on ubuntu
file "/etc/init.d/newrelic-sysmond" do
  action :delete
end

cookbook_file "/etc/init/newrelic-sysmond.conf" do
  source "newrelic-sysmond-#{node["platform_family"]}.conf"
  owner "root"
  group "root"
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
  provider Chef::Provider::Service::Upstart
  supports status: true, restart: true
  action [:enable, :start]
end
