require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => "db/ar-students.sqlite3"
)

require_relative 'app/models/student'
# Note: add any other models / classes that need to be required here (eg: Teacher)
