class AddSignUpNumberToBidList < ActiveRecord::Migration
  def change
    add_column :bid_lists, :sign_up_number, :text
  end
end
