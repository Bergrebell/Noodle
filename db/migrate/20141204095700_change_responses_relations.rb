class ChangeResponsesRelations < ActiveRecord::Migration
  def change
    rename_column :responses, :select_date_id, :selectdate_id

  end
end
