# HINT: checkout ActiveRecord::Migration.create_table

class CreateStudents < ActiveRecord::Migration
  
  def change
    # Code to create the table here:
    create_table :students do |t|
      # column definitions go here
      # Use the AR migration guide for syntax reference
    end
  end

end
