require 'active_record'

DATABASE = ENV['TEST'] == '1' ? 'test' : 'development'

puts "Connecting to 'db/#{DATABASE}.sqlite3' db ..."
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => "db/#{DATABASE}.sqlite3"
)

require_relative 'app/models/student'
# Note: add any other models / classes that need to be required here (eg: Teacher)
