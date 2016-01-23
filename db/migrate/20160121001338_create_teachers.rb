class CreateTeachers < ActiveRecord::Migration
  
  def change
    create_table :teachers do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :email, :string
      t.column :phone, :string
      t.timestamps null: false
    end
  end

end