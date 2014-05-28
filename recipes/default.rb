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
    uri "http://apt.newrelic.com/debian/"
    components %w[newrelic non-free]
    key "548C16BF"
    keyserver node["new_relic"]["keyserver"]
  end
elsif platform_family?("rhel")
  yum_repository 'newrelic' do
    baseurl "https://yum.newrelic.com/pub/newrelic/el5/#{node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'i386'}"
    gpgcheck false
    enabled true
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
