# chef-newrelic-sysmond

## Description

Installs [newrelic-sysmond](https://newrelic.com/docs/server/new-relic-for-server-monitoring), New Relic for Server Monitoring.


## Requirements

### Supported Platforms

The following platforms are supported by this cookbook, meaning that the recipes run on these platforms without error:

* Debian
* Ubuntu
* Red Hat Enterprise Linux 5 & 6
* CentOS 5 & 6

## Recipes

* `newrelic-sysmond` - The default recipe.

## Usage

This cookbook installs the newrelic-sysmond components if not present, and pulls updates if they are installed on the system.

## Attributes

```ruby
default["new_relic"]["keyserver"]      = "subkeys.pgp.net"
default["new_relic"]["license_key"]    = ""
default["new_relic"]["loglevel"]       = "info"
default["new_relic"]["logfile"]        = "/var/log/newrelic/nrsysmond.log"
default["new_relic"]["proxy"]          = ""
default["new_relic"]["ssl"]            = "false"
default["new_relic"]["ssl_ca_bundle"]  = ""
default["new_relic"]["ssl_ca_path"]    = ""
default["new_relic"]["pidfile"]        = ""
default["new_relic"]["collector_host"] = "collector.newrelic.com"
default["new_relic"]["timeout"]        = 30
```


## Basic Settings

You must set the value for `node["new_relic"]["license_key"]`


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



## Contributors

Many thanks go to the following [contributors](https://github.com/phlipper/chef-newrelic-sysmond/graphs/contributors) who have helped to make this cookbook even better:

* **[@dwradcliffe](https://github.com/dwradcliffe)**
    * add support for redhat/centos


## License

**chef-newrelic-sysmond**

* Freely distributable and licensed under the [MIT license](http://phlipper.mit-license.org/2011-2013/license.html).
* Copyright (c) 2011-2013 Phil Cohen (github@phlippers.net) [![endorse](http://api.coderwall.com/phlipper/endorsecount.png)](http://coderwall.com/phlipper)
* http://phlippers.net/
