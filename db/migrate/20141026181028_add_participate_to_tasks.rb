class AddParticipateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :participate, :boolean
  end
end
