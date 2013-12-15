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

class Array
  def mode
    sort_by {|i| grep(i).length }.last
  end
end

class Entry < ActiveRecord::Base
  attr_accessible :user_id, :text, :user_mood_input, :lat, :long, :temperture, :humidity, :word_count, :most_common_adjective, :most_common_adverb, :tense_orientation, :created_at, :updated_at
  attr_reader :instance_entities, :instance_relations, :tenses
  validates :user_id, :text, :user_mood_input, :word_count, :presence => true
  validates_numericality_of :user_id, :word_count
  validates :text, length: { minimum: 10, too_short: "is too short (minimum is 10 characters)" }
  has_many :entities
  after_initialize :get_entities_and_relations
  after_update :update_entities
  before_destroy :destroy_entities

  # TODO I keep getting the following error:  'getaddrinfo: nodename nor servname provided, or not known' Why?

  def destroy_entities
    self.entities.each do |entity|
      entity.destroy
    end
  end

  def get_entities_and_relations
    alchemy_api = Alchemy.new()
    @instance_entities = alchemy_api.entities('text', self.text, { sentiment: 1 })["entities"]
    @instance_relations = alchemy_api.relations('text', self.text)["relations"]
    @tenses = []
    @instance_relations.each do |relation|
      @tenses << relation["action"]["verb"]["tense"]
    end
    @most_used_tense = @tenses.group_by(&:to_s).values.max_by(&:size).first
    # TODO write Array.method for handling cases where there are multiple modes, see below:
    # class Array
      # def mode
      #   sort_by {|i| grep(i).length }.last
      # end
    # end
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
    self.get_entities_and relations
    self.create_entities(self.instance_entities)
  end # update_entities

end
