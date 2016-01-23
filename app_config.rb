require 'active_record'
require 'active_support/all'
require './lib/students_importer'
require './app/models/student'
require './app/models/teacher'
require './lib/teachers_importer'

module AppConfig

  DATABASE = ENV['DATABASE'] || 'development'

  DATABASE_PATH = File.absolute_path("db/#{DATABASE}.sqlite3", File.dirname(__FILE__))

  def self.establish_connection
    puts "Connecting to database '#{DATABASE_PATH}'"
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: DATABASE_PATH
    )
  end

end
