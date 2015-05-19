require 'active_record'
require 'active_support/all'
require './lib/students_importer'
require './app/models/student'
# Add new app/ and lib/ files here when they are created.

DATABASE = ENV['DATABASE'] || 'development'
DATABASE_PATH = File.absolute_path("db/#{DATABASE}.sqlite3", File.dirname(__FILE__))

puts "Connecting to database '#{DATABASE_PATH}'"

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: DATABASE_PATH
)
