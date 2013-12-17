class AddHourCreatedColumnEntries < ActiveRecord::Migration
  def change
    add_column :entries, :hour_created, :integer
  end
end
