class CreateSelectdates < ActiveRecord::Migration
  def change
    create_table :selectdates do |t|
      t.datetime :task_date
      t.boolean :participate
      t.belongs_to :attendee
      t.timestamps
    end
  end
end
