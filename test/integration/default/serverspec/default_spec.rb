require "serverspec"

set :backend, :exec

describe "`newrelic-sysmond` installation" do
  describe package("newrelic-sysmond") do
    it { should be_installed }
  end

  if os[:family] == "redhat"
    describe command("initctl list") do
      its(:stdout) { should match(/newrelic\-sysmond start\/running/) }
      its(:exit_status) { should eq 0 }
    end

    describe command("pgrep nrsysmond") do
      its(:stdout) { should match(/\d+/) }
      its(:exit_status) { should eq 0 }
    end
  else
    describe service("newrelic-sysmond") do
      it { should be_enabled }
      it { should be_running }
    end
  end

  describe file("/etc/newrelic/nrsysmond.cfg") do
    it { should be_a_file }
    it { should be_owned_by "root" }
    it { should be_grouped_into "newrelic" }
    it { should be_mode 640 }
  end

  describe file("/etc/init/newrelic-sysmond.conf") do
    it { should be_a_file }
    it { should be_owned_by "root" }
    it { should be_grouped_into "root" }
    it { should be_mode 644 }
  end
end
