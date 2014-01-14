class AddBidNumberToActivity < ActiveRecord::Migration
  def change
    add_column :activities,:bid_number,:text
  end
end
