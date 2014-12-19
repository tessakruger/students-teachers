ENV['TEST'] = '1'
require_relative './config'

require 'rake'
load 'Rakefile'

puts "Preparing (re-building) test db ... "
puts "============================"

Rake::Task["db:drop"].invoke
Rake::Task["db:create"].invoke
Rake::Task["db:migrate"].invoke
Rake::Task["db:populate"].invoke

puts "Done preparing, running tests ... "
puts "============================"