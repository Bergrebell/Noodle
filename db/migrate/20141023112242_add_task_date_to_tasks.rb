class AddTaskDateToTasks < ActiveRecord::Migration
  def change
    #migration do add the task_date field to the DB
    add_column :tasks, :task_date, :datetime
  end
end
