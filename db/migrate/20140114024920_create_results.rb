class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.text :user
      t.text :activity_name
      t.text :bid_name
      t.text :result
      t.timestamps
    end
  end
end
