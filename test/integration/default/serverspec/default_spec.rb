require "serverspec"

set :backend, :exec

describe "`newrelic-sysmond` installation" do
  describe package("newrelic-sysmond") do
    it { should be_installed }
  end

  describe service("newrelic-sysmond") do
    it { should be_enabled }
    it { should be_running }
  end

  describe file("/etc/newrelic/nrsysmond.cfg") do
    it { should be_a_file }
    it { should be_owned_by "root" }
    it { should be_grouped_into "newrelic" }
    it { should be_mode 640 }
  end
end
