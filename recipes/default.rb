#
# Cookbook Name:: newrelic-sysmond
# Recipe:: default
#
# Copyright 2011-2012, Phil Cohen
#

unless node["new_relic"]["license_key"].empty?

  case node['platform']
  when "debian", "ubuntu"
    
    apt_repository "newrelic" do
      uri "http://apt.newrelic.com/debian/"
      components ["newrelic", "non-free"]
      key "548C16BF"
      keyserver node["new_relic"]["keyserver"]
      action :add
    end

  when "redhat", "centos", "amazon", "scientific"

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
    mode 0640
    notifies :restart, "service[newrelic-sysmond]"
  end

  service "newrelic-sysmond" do
    action [:enable, :start]
  end

end
