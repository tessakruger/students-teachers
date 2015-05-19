require './config'
require 'rspec/core/rake_task'
require 'active_record/schema_dumper'

desc 'create the database'
task 'db:create' do
  touch DATABASE_PATH
end

desc 'drop the database'
task 'db:drop' do
  rm_f DATABASE_PATH
end

desc 'dump the database'
task 'db:schema:dump' do
  filename = File.absolute_path('db/schema.rb', File.dirname(__FILE__))
  File.open(filename, 'w:utf-8') do |file|
    ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
  end
end

desc 'migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog).'
task 'db:migrate' do
  ActiveRecord::Migration.verbose = ENV['VERBOSE'] ? ENV['VERBOSE'] == 'true' : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV['VERSION'] ? ENV['VERSION'].to_i : nil) do |migration|
    ENV['SCOPE'].blank? || (ENV['SCOPE'] == migration.scope)
  end
  Rake::Task['db:schema:dump'].invoke
end

desc 'rollback the database (options: VERSION=x, VERBOSE=false, STEPS=1).'
task 'db:rollback' do
  ActiveRecord::Migration.verbose = ENV['VERBOSE'] ? ENV['VERBOSE'] == 'true' : true
  ActiveRecord::Migrator.rollback(ActiveRecord::Migrator.migrations_paths, ENV['STEPS'] ? ENV['STEPS'].to_i : 1)
  Rake::Task['db:schema:dump'].invoke
end

desc 'populate the test database with data'
task 'db:populate' do
  StudentsImporter.new.import
end

desc 'Retrieves the current schema version number'
task 'db:version' do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end
