# chef-newrelic-sysmond  [![Build Status](https://travis-ci.org/phlipper/chef-newrelic-sysmond.png?branch=master)](https://travis-ci.org/phlipper/chef-newrelic-sysmond)

## Description

Installs [newrelic-sysmond](https://newrelic.com/docs/server/new-relic-for-server-monitoring), New Relic for Server Monitoring.


## Requirements

### Chef

This cookbook requires Chef >= 11.13 due to the use of the `sensitive` attribute for some resources.

### Cookbooks

The following cookbooks are direct dependencies:

* [apt](https://supermarket.getchef.com/cookbooks/apt) (for Debian and Ubuntu)
* [yum](https://supermarket.getchef.com/cookbooks/yum) (for RHEL and CentOS)

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
default["newrelic-sysmond"]["apt_uri"]        = "http://apt.newrelic.com/debian/"
default["newrelic-sysmond"]["apt_key"]        = "548C16BF"
default["newrelic-sysmond"]["keyserver"]      = "hkp://keyserver.ubuntu.com:80"
default["newrelic-sysmond"]["yum_baseurl"]    = "https://yum.newrelic.com/pub/newrelic/el5/#{node["kernel"]["machine"]}"
default["newrelic-sysmond"]["license_key"]    = ""
default["newrelic-sysmond"]["loglevel"]       = "info"
default["newrelic-sysmond"]["logfile"]        = "/var/log/newrelic/nrsysmond.log"
default["newrelic-sysmond"]["proxy"]          = ""
default["newrelic-sysmond"]["ssl"]            = "true"
default["newrelic-sysmond"]["ssl_ca_bundle"]  = ""
default["newrelic-sysmond"]["ssl_ca_path"]    = ""
default["newrelic-sysmond"]["pidfile"]        = "/var/run/newrelic/nrsysmond.pid"
default["newrelic-sysmond"]["collector_host"] = "collector.newrelic.com"
default["newrelic-sysmond"]["timeout"]        = 30
default["newrelic-sysmond"]["hostname"]       = ""
default["newrelic-sysmond"]["labels"]         = ""
```


## Basic Settings

You must set the value for `node["newrelic-sysmond"]["license_key"]`


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
* **[@fredjean](https://github.com/fredjean)**
    * fix default keyserver host name
* **[@joe1chen](https://github.com/joe1chen)**
    * add apt dependency to metadata
* **[@CloCkWeRX](https://github.com/CloCkWeRX)**
    * initial implementation of `hostname` attribute
* **[@apai4](https://github.com/apai4)**
    * add 64bit yum repo support
* **[@jhsu](https://github.com/jhsu)**
    * add `apt_uri` and `apt_key` attributes
* **[@jolexa](https://github.com/jolexa)**
    * add `yum_baseurl` attribute


## License

**chef-newrelic-sysmond**

* Freely distributable and licensed under the [MIT license](http://phlipper.mit-license.org/2011-2014/license.html).
* Copyright (c) 2011-2014 Phil Cohen (github@phlippers.net) [![endorse](http://api.coderwall.com/phlipper/endorsecount.png)](http://coderwall.com/phlipper)  [![Gittip](http://img.shields.io/gittip/phlipper.png)](https://www.gittip.com/phlipper/)
* http://phlippers.net/
