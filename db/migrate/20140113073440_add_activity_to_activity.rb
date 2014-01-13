class AddActivityToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :activity_name, :text
    add_column :activities, :sign_up_number, :text
  end
end
