require_relative '../../config'

# This is where you should use an ActiveRecord migration to
# HINT: checkout ActiveRecord::Migration.create_table

class CreateStudents < ActiveRecord::Migration
  
  def up
    # Code to create the table here:
    create_table :students do |t|
      # column definitions go here
      # Use the AR migration guide for syntax reference
    end
  end

  def down
    # Code to drop the table here
    # Use the AR migration guide for syntax reference
    drop_table :students
  end
  
end
