class RemovePasswordConfirmationFormUser < ActiveRecord::Migration
  def change
    remove_column :users ,:password_confirmation,:text

  end
end
