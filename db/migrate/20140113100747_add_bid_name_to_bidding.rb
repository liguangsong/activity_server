class AddBidNameToBidding < ActiveRecord::Migration
  def change
    add_column :biddings, :bid_name, :text
  end
end
