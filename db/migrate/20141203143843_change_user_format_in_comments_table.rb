class ChangeUserFormatInCommentsTable < ActiveRecord::Migration
  def change
    change_column :comments, :user_id, :string
    rename_column :comments, :user_id, :username
  end
end
