require "chefspec"
require "chefspec/berkshelf"

def add_apt_repository(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:apt_repository, :add, resource_name)
end

at_exit { ChefSpec::Coverage.report! }
