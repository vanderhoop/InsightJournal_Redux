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

require 'alchemy'

class Entry < ActiveRecord::Base
  attr_accessible :user_id, :text, :user_mood_input, :lat, :long, :temperture, :humidity, :word_count, :most_common_adjective, :most_common_adverb, :tense_orientation, :created_at, :updated_at
  attr_reader :instance_entities
  validates :user_id, :text, :user_mood_input, :word_count, :presence => true
  validates_numericality_of :user_id, :word_count
  validates :text, length: { minimum: 10, too_short: "is too short (minimum is 10 characters)" }
  has_many :entities
  after_initialize :get_entities
  after_update :update_entities
  after_destroy :destroy_entities


  def destroy_entities
    self.entities.each do |entity|
      entity.destroy
    end
  end

  def get_entities
    alchemy_api = Alchemy.new()
    @instance_entities = alchemy_api.entities('text', self.text, { sentiment: 1 })["entities"]
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

  def update_entities
    self.destroy_entities
    self.get_entities
    self.create_entities(self.instance_entities)
  end # update_entities

end
