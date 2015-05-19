# Hard code the DATABASE environment variable so that it only connects
# to the test database when running rspec. Take a look inside config.rb
# to see how this value is being used.
ENV['DATABASE'] = 'test'
require './config'

# Clean the database between each test run using the database cleaner
require 'database_cleaner'

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
