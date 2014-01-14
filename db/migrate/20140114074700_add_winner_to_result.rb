class AddWinnerToResult < ActiveRecord::Migration
  def change
    add_column :results,:name,:text
    add_column :results,:price,:text
    add_column :results,:phone,:text
  end
end
