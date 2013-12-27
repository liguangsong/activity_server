class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name
      t.text :password
      t.text :question
      t.text :answer

      t.timestamps
    end
  end
end
