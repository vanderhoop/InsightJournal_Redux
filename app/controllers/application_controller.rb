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

  def get_tense_mode(entries)
   # retrieves tense_orientation values and removes any nil values
   tense_orientations = entries.to_a.plucky("tense_orientation").compact
   tense_mode = tense_orientations.mode
  end

  def return_insights_hash(ents)
    insights_hash = {}
    insights_hash[:sample_size] = ents.size
    if ents.size == 0
      return insights_hash
    else
      insights_hash[:avg_mood] = ents.average("user_mood_input")
      insights_hash[:avg_word_count] = ents.average("word_count")
      insights_hash[:tense_mode] = get_tense_mode(ents)
      insights_hash
    end
  end #return insights_hash

  def filter_entries_by_time_written(array_of_entries, time_of_day)
    case time_of_day
    when "none"
      return array_of_entries
    when "morning"
      a = 0
      b = 12
    when "afternoon"
      a = 12
      b = 17
    when "night"
      a = 17
      b = 24
    else
    end

    array_of_entries.select do |entry|
      entry["created_at"].in_time_zone("Eastern Time (US & Canada)").hour.between?(a,b)
    end
  end # filter_entries_by_time_written

end
