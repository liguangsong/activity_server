class AddStatusToactivity < ActiveRecord::Migration
  def change
    add_column :activities, :status, :text
  end
end
