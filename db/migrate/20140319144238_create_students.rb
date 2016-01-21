class CreateStudents < ActiveRecord::Migration
  
  def change
    # Add code to create the table here
    # HINT: check out ActiveRecord::Migration.create_table
    create_table :students do |t|
      # column definitions go here
      # Use the AR migration guide for syntax reference
    end
  end

end
