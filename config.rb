require 'active_record'
require 'database_cleaner'

DATABASE = ENV['TEST'] == '1' ? 'test' : 'development'

puts "Connecting to 'db/#{DATABASE}.sqlite3' db ..."
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => "db/#{DATABASE}.sqlite3"
)

# Clean the database between each test run using the database cleaner
RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end


require_relative 'app/models/student'
# Note: add any other models / classes that need to be required here (eg: Teacher)
