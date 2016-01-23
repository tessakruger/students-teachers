class CreateStudents < ActiveRecord::Migration
  
  def change
    create_table :students do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :gender, :string
      t.column :email, :string
      t.column :phone, :string
      t.column :birthday, :date
      t.timestamps null: false
    end
  end

end
