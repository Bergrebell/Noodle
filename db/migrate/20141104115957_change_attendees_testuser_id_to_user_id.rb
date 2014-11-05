class ChangeAttendeesTestuserIdToUserId < ActiveRecord::Migration
  def change
    rename_column :attendees, :testuser_id, :user_id
  end
end
