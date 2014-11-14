class AddTaskidToSelectdate < ActiveRecord::Migration
  def change
    add_column :selectdates, :task_id, :integer
  end
end
