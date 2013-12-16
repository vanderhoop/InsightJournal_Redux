class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :user_instance

  require 'alchemy'

  def user_instance
    @user = current_user
  end

  def get_relations(text)
    alchemy_api = Alchemy.new()
    relations = alchemy_api.relations('text', text)["relations"]
    tenses = []
    relations.each do |relation|
      tenses << relation["action"]["verb"]["tense"]
    end
    tenses.mode
  end

  def avg_mood_score(entries)
    avg_mood = entries.average("user_mood_input")
  end

  def avg_word_count(entries)
    avg_word_count = entries.average("word_count")
  end

  def get_tense_mode(entries)
   # retrieves tense_orientation values and removes any nil values
   tense_orientations = entries.pluck(:tense_orientation).compact
   tense_mode = tense_orientations.mode
  end

end
