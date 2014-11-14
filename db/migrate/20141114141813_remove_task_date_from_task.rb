class RemoveTaskDateFromTask < ActiveRecord::Migration
  def change
    remove_column :tasks, :task_date, :datetime
  end
end
