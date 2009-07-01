require 'rubygems'
#require 'gearman'
require '../lib/gearman'

Gearman::Util.debug = true

servers = ['localhost:4730','localhost:4731']
w = Gearman::Worker.new(servers)

# Add a handler for a "sleep" function that takes a single argument, the
# number of seconds to sleep before reporting success.
w.add_ability('fail_with_exception') do |data,job|
  raise Exception.new("fooexception")
end
loop { w.work }
