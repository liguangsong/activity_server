class AddPasswordConfirmationToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_confirmation, :text
  end
end
