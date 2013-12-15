class ChangeTypeColumn < ActiveRecord::Migration
  def change
    rename_column :entities, :type, :e_type
  end
end
