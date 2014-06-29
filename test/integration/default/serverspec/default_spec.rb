require "serverspec"
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe "newrelic-sysmond::default" do
  it "installed `newrelic-sysmond`" do
    expect(package "newrelic-sysmond").to be_installed
  end
end
