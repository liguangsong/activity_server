class RemoveActivitiesFromActivity < ActiveRecord::Migration
  def change
    remove_column :activities, :activities, :text
  end
end
