class CreateSignUps < ActiveRecord::Migration
  def change
    create_table :sign_ups do |t|
      t.text :activity_name
      t.text :name
      t.text :phone
      t.text :user

      t.timestamps
    end
  end
end
