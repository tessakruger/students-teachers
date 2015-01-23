ENV['TEST'] = '1'
require_relative './config'

require 'rake'
require 'rspec'
require 'database_cleaner'

load 'Rakefile'

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
