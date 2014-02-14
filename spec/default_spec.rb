require "spec_helper"

describe "newrelic-sysmond::default" do

  # no license key == no action
  context "with no `license_key` attribute" do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it "logs a warning about the missing license key" do
      # `write_log` should match a regex :\
      expect(chef_run).to write_log(<<-EOM
The `newrelic-sysmond` recipe was included, but a licence key was not provided.
Please set `node["new_relic"]["license_key"]` to avoid this warning.
EOM
      ).with(level: :warn)
    end

    it "does not install the `newrelic-sysmond` package" do
      expect(chef_run).to_not install_package("newrelic-sysmond")
    end

    it "does not create the configuration file" do
      expect(chef_run).to_not create_template("/etc/newrelic/nrsysmond.cfg")
    end
  end

  # debian family setup
  context "using debian platform family" do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: "ubuntu", version: "12.04") { |node|
        node.set["new_relic"]["license_key"] = "abc123"
      }.converge(described_recipe)
    end

    it "sets up an apt repository" do
      expect(chef_run).to add_apt_repository("newrelic")
    end
  end

  # rhel family setup
  context "using rhel platform family" do
    let(:yum_cmd) { "yum list installed | grep newrelic-repo.noarch" }

    let(:chef_run) do
      ChefSpec::Runner.new(platform: "centos", version: "6.3") { |node|
        node.set["new_relic"]["license_key"] = "abc123"
      }.converge(described_recipe)
    end

    context "when `newrelic-repo.noarch` is not installed" do
      before { stub_command(yum_cmd).and_return(false) }

      it "adds the New Relic Yum repository" do
        expect(chef_run).to run_execute("Add New Relic yum repository")
      end
    end

    context "when `newrelic-repo.noarch` is installed" do
      before { stub_command(yum_cmd).and_return(true) }

      it "does not add the New Relic Yum repository" do
        expect(chef_run).to_not run_execute("Add New Relic yum repository")
      end
    end
  end


  # default recipe run
  context "default run" do
    let(:chef_run) do
      ChefSpec::Runner.new { |node|
        node.set["new_relic"]["license_key"] = "abc123"
      }.converge(described_recipe)
    end

    it "installs the `newrelic-sysmond` package" do
      expect(chef_run).to install_package("newrelic-sysmond")
    end

    it "enables the newrelic-sysmond service at startup" do
      expect(chef_run).to enable_service("newrelic-sysmond")
    end

    it "starts the newrelic-sysmond service" do
      expect(chef_run).to start_service("newrelic-sysmond")
    end

    it "creates the configuration file" do
      expect(chef_run).to create_template("/etc/newrelic/nrsysmond.cfg").with(
        source: "nrsysmond.cfg.erb",
        owner: "root",
        group: "newrelic",
        mode: "0640"
      )

      expect(chef_run).to(
        render_file("/etc/newrelic/nrsysmond.cfg").with_content(
          "license_key=abc123"
        )
      )
    end
  end

end
