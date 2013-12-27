class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.text :name
      t.text :password
      t.text :question
      t.text :answer

      t.timestamps
    end
  end
end
