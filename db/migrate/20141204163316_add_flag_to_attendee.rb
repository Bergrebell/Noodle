class AddFlagToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :answered, :boolean
  end
end
