require "spec_helper"

describe "newrelic-sysmond::default" do
  let(:config_file) do
    "/etc/newrelic/nrsysmond.cfg"
  end

  let(:init_script) do
    "/etc/init.d/newrelic-sysmond"
  end

  let(:upstart_script) do
    "/etc/init/newrelic-sysmond.conf"
  end

  # no license key == no action
  context "with no `license_key` attribute" do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it "logs a warning about the missing license key" do
      # `write_log` should match a regex :\
      expect(chef_run).to write_log(<<-EOM
The `newrelic-sysmond` recipe was included, but a licence key was not provided.
Please set `node["newrelic-sysmond"]["license_key"]` to avoid this warning.
        EOM
      ).with(level: :warn)
    end

    it "does not install the `newrelic-sysmond` package" do
      expect(chef_run).to_not install_package("newrelic-sysmond")
    end

    it "does not create the configuration file" do
      expect(chef_run).to_not create_template(config_file)
    end
  end

  # debian family setup
  context "using debian platform family" do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: "ubuntu", version: "12.04") do |node|
        node.set["newrelic-sysmond"]["license_key"] = "abc123"
      end.converge(described_recipe)
    end

    it "sets up an apt repository" do
      expect(chef_run).to add_apt_repository("newrelic")
    end

    it "removes the default initscript" do
      expect(chef_run).to delete_file(init_script)
    end

    it "provides an upstart initscript" do
      expect(chef_run).to create_cookbook_file(upstart_script).with(
        owner: "root",
        group: "root"
      )
    end
  end

  # rhel family setup
  context "using rhel platform family" do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: "centos", version: "6.3") do |node|
        node.set["newrelic-sysmond"]["license_key"] = "abc123"
      end.converge(described_recipe)
    end

    it "sets up a yum repository" do
      expect(chef_run).to create_yum_repository("newrelic")
    end

    it "removes the default initscript" do
      expect(chef_run).to delete_file(init_script)
    end

    it "provides an upstart initscript" do
      expect(chef_run).to create_cookbook_file(upstart_script)
    end
  end

  # default recipe run
  context "default run" do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set["newrelic-sysmond"]["license_key"] = "abc123"
      end.converge(described_recipe)
    end

    it "installs the `newrelic-sysmond` package" do
      expect(chef_run).to install_package("newrelic-sysmond")
    end

    it "ensures that the `pidfile` directory exists" do
      expect(chef_run).to create_directory("/var/run/newrelic").with(
        owner: "newrelic",
        group: "newrelic",
        recursive: true
      )
    end

    it "enables the newrelic-sysmond service at startup" do
      expect(chef_run).to enable_service("newrelic-sysmond")
    end

    it "starts the newrelic-sysmond service" do
      expect(chef_run).to start_service("newrelic-sysmond")
    end

    it "creates the configuration file" do
      expect(chef_run).to create_template(config_file).with(
        source: "nrsysmond.cfg.erb",
        owner: "root",
        group: "newrelic",
        mode: "0640",
        sensitive: true
      )

      expect(chef_run).to(
        render_file(config_file).with_content("license_key=abc123")
      )

      expect(chef_run.template(config_file)).to(
        notify("service[newrelic-sysmond]").to(:restart)
      )
    end
  end
end
