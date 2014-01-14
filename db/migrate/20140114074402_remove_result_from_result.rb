class RemoveResultFromResult < ActiveRecord::Migration
  def change
    remove_column :results,:result,:text
  end
end
