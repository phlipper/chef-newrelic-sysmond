#
# Cookbook Name:: newrelic-sysmond
# Recipe:: default
#
# Copyright 2011-2014, Phil Cohen
#

if node["new_relic"]["license_key"].empty?
  log "message" do
      message "newrelic-sysmond recipe included, but licence key not provided."
      level :warn
  end

  return
end

if platform_family?("debian")
  apt_repository "newrelic" do
    uri "http://apt.newrelic.com/debian/"
    components ["newrelic", "non-free"]
    key "548C16BF"
    keyserver node["new_relic"]["keyserver"]
  end
elsif platform_family?("rhel")
  execute "Add New Relic yum repository" do
    command "rpm -Uvh http://download.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm"
    not_if "yum list installed | grep newrelic-repo.noarch"
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
