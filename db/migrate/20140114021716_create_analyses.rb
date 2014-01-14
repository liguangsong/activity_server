class CreateAnalyses < ActiveRecord::Migration
  def change
    create_table :analyses do |t|
      t.text :user
      t.text :activity_name
      t.text :bid_name
      t.text :price
      t.text :number
      t.timestamps
    end
  end
end
