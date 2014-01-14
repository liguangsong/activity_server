class CreateBidLists < ActiveRecord::Migration
  def change
    create_table :bid_lists do |t|
      t.text :user
      t.text :activity_name
      t.text :bid_name
      t.text :number
      t.text :status

      t.timestamps
    end
  end
end
