class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :task_id
      t.integer :user_id
      t.boolean :participate

      t.timestamps
    end
  end
end
