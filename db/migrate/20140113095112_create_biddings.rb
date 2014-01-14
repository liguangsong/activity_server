class CreateBiddings < ActiveRecord::Migration
  def change
    create_table :biddings do |t|
      t.text :user
      t.text :activity_name
      t.text :name
      t.text :phone
      t.text :price

      t.timestamps
    end
  end
end
