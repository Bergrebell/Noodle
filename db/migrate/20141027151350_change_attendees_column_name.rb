class ChangeAttendeesColumnName < ActiveRecord::Migration
  def change
    rename_column :attendees, :user_id, :testuser_id
  end
end
