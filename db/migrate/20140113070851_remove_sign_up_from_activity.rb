class RemoveSignUpFromActivity < ActiveRecord::Migration
  def change
    remove_column :activities,:sign_up,:text
    remove_column :activities,:bids,:text
  end
end
