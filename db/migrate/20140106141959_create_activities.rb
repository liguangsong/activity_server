class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :user_name
      t.string :activities

      t.timestamps
    end
  end
end
