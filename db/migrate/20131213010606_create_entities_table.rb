class CreateEntitiesTable < ActiveRecord::Migration
  def change
      create_table :entities do |t|
        t.integer  :entry_id
        t.string   :string_representation
        t.integer  :count
        t.string   :type
        t.string   :sentiment_type
        t.float    :sentiment_score
        t.timestamps
      end
  end
end
