class AddSelectDatesToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :meeting_date, :date
    add_column :tasks, :meeting_start_time, :time
    add_column :tasks, :meeting_end_time, :time
  end
end
