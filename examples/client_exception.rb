require 'rubygems'
require '../lib/gearman'
Gearman::Util.debug = true

servers = ['localhost:4730']

client = Gearman::Client.new(servers)
taskset = Gearman::TaskSet.new(client)

task = Gearman::Task.new('fail_with_exception', "void")
task.retry_count = 1
task.on_complete {|d| puts d }
task.on_exception {|ex| puts "This should never be called" }
task.on_warning {|warning| puts "WARNING: #{warning}" }
task.on_fail { puts "TASK FAILED" }

taskset.add_task(task)
taskset.wait(100)
