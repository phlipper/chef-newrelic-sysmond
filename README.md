# DESCRIPTION

Installs [newrelic-sysmond](https://newrelic.com/docs/server/new-relic-for-server-monitoring), New Relic for Server Monitoring.


# REQUIREMENTS

## Supported Platforms

The following platforms are supported by this cookbook, meaning that the recipes run on these platforms without error:

* Ubuntu

# RECIPES

* `newrelic-sysmond` - The default recipe.

# USAGE

This cookbook installs the newrelic-sysmond components if not present, and pulls updates if they are installed on the system.

# ATTRIBUTES

* `node[:new_relic][:license_key]`    default: ""
* `node[:new_relic][:loglevel]`       default: "info"
* `node[:new_relic][:logfile]`        default: "/var/log/newrelic/nrsysmond.log"
* `node[:new_relic][:proxy]`          default: ""
* `node[:new_relic][:ssl]`            default: "false"
* `node[:new_relic][:ssl_ca_bundle]`  default: ""
* `node[:new_relic][:ssl_ca_path]`    default: ""
* `node[:new_relic][:pidfile]`        default: ""
* `node[:new_relic][:collector_host]` default: "collector.newrelic.com"
* `node[:new_relic][:timeout]`        default: 30

## Basic Settings

You must set the value for `node[:new_relic][:license_key]`


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

**chef-newrelic-sysmond**

* Freely distributable and licensed under the [MIT license](http://phlipper.mit-license.org/2011-2012/license.html).
* Copyright (c) 2011-2012 Phil Cohen (github@phlippers.net) [![endorse](http://api.coderwall.com/phlipper/endorsecount.png)](http://coderwall.com/phlipper)
* http://phlippers.net/
