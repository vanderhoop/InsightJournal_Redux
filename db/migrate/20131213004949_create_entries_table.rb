class CreateEntriesTable < ActiveRecord::Migration
  def change
      create_table :entries do |t|
        t.integer  :user_id
        t.text     :text
        t.integer  :user_mood_input
        t.float    :lat
        t.float    :long
        t.integer  :temperature
        t.float    :humidity
        t.integer  :word_count
        t.string   :most_common_adjective
        t.string   :most_common_adverb
        t.string   :subject
        t.timestamps
      end
  end
end
