class AddTenseOrientationColumnToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :tense_orientation, :string
  end
end
