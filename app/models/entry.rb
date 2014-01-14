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
#  hour_created          :integer
#
require 'alchemy'

class Entry < ActiveRecord::Base
  attr_accessible :user_id, :text, :user_mood_input, :lat, :long, :temperture, :humidity, :word_count, :most_common_adjective, :most_common_adverb, :tense_orientation, :created_at, :updated_at, :hour_created
  attr_reader :instance_entities, :instance_relations, :tenses, :most_used_tense

  validates :user_id, :text, :user_mood_input, :word_count, :hour_created, :presence => true
  validates_numericality_of :user_id, :word_count, :hour_created
  validates_length_of :text, minimum: 10, too_short: "is too short (minimum is 10 characters)"

  has_many :entities
  belongs_to :user

  # get_entities and get_relation set crucial values
  # to the Entry before it's saved to the db
  # after_initialize :set_hour_created
  before_save :get_entities, :set_relations, :set_hour_created
  after_update :update_entities
  before_destroy :destroy_entities

  # custom active record functions for culling Entries
  scope :past, where(:tense_orientation => 'past')
  scope :present, where(:tense_orientation => 'present')
  scope :future, where(:tense_orientation => 'future')

  scope :morning, where(:hour_created => 0..12 )
  scope :afternoon, where(:hour_created => 13..17 )
  scope :night, where(:hour_created => 18..24 )

  # TODO I keep getting the following error: 'getaddrinfo: nodename nor servname provided, or not known' Why?
  # TODO customize Array.mode method (in config/environment) for handling cases where there are multiple modes.

  def set_hour_created
    self.hour_created = Time.now.in_time_zone('Eastern Time (US & Canada)').hour
  end

  # sets instance_entities
  def get_entities
    alchemy_api = Alchemy.new()
    @instance_entities = alchemy_api.entities('text', self.text, { sentiment: 1 })["entities"]
  end #get_entities

  # sets tense_orientation before .save
  def set_relations
    alchemy_api = Alchemy.new()
    @instance_relations = alchemy_api.relations('text', self.text)["relations"]
    @tenses = []
    @instance_relations.each do |relation|
      @tenses << relation["action"]["verb"]["tense"]
    end
    self.tense_orientation = @tenses.mode
  end # get_relations

  def destroy_entities
    self.entities.each do |entity|
      entity.destroy
    end
  end # destroy_entities

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
