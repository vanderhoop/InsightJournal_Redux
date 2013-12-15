# == Schema Information
#
# Table name: entries
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  text                  :text
#  user_mood_input       :integer
#  lat                   :float
#  long                  :float
#  temperature           :integer
#  humidity              :float
#  word_count            :integer
#  most_common_adjective :string(255)
#  most_common_adverb    :string(255)
#  subject               :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  tense_orientation     :string(255)
#

class Entry < ActiveRecord::Base
  attr_accessible :user_id, :text, :user_mood_input, :lat, :long, :temperture, :humidity, :word_count, :most_common_adjective, :most_common_adverb, :tense_orientation, :created_at, :updated_at
  validates :user_id, :text, :user_mood_input, :word_count, :presence => true
  validates_numericality_of :user_id, :word_count
  validates :text, length: { minimum: 10, too_short: "is too short (minimum is 10 characters)" }

  has_many :entities

  def hello_test
    "hello"
  end

  def create_entities(entities_array)
    entities_array.each do |entity|
      sentiment = entity["sentiment"]
      Entity.create({
        entry_id: self.id,
        string_representation: entity["text"],
        count: entity["count"],
        e_type: entity["type"],
        sentiment_type: sentiment["type"],
        sentiment_score: sentiment["score"]
      })
    end
  end #create_entities

end
