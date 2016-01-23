class CreateStudents < ActiveRecord::Migration
  
  def change
<<<<<<< HEAD
    create_table :students do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :gender, :string
      t.column :email, :string
      t.column :phone, :string
      t.column :birthday, :date
      t.timestamps null: false
=======
    # Add code to create the table here
    # HINT: check out ActiveRecord::Migration.create_table
    create_table :students do |t|
      # column definitions go here
      # Use the AR migration guide for syntax reference
>>>>>>> b82466980e979d246c4480fc38cf2d01a9788fbc
    end
  end

end
