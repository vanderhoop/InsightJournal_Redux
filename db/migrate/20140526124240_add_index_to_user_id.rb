class AddIndexToUserId < ActiveRecord::Migration
  def change
    add_index :entries, :user_id
    add_index :entities, :entry_id
  end
end
