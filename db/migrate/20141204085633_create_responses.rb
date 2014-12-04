class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :select_date_id
      t.integer :user_id
      t.boolean :attend

      t.timestamps
    end
  end
end
