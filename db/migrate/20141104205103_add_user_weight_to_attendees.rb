class AddUserWeightToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :user_weight, :integer
  end
end
