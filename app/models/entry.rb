class Entry < ActiveRecord::Base
  attr_accessible :user_id, :text, :user_mood_input, :lat, :long, :temperture, :humidity, :word_count, :most_common_adjective, :most_common_adverb, :tense_orientation
  validates :user_id, :text, :user_mood_input, :presence => true

  has_many :entities
end
