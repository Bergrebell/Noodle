class RefactorDatabase < ActiveRecord::Migration
  def change
    remove_column :tasks, :meeting_date, :date
    remove_column :tasks, :meeting_start_time, :time
    remove_column :tasks, :meeting_end_time, :time
    remove_column :selectdates, :participate, :boolean
  end
end
