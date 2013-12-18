class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :user_instance
  before_filter :quotes

  require 'alchemy'

  def quotes
    @sampled_quote = [
      { quote: "Since people are going to be living longer and getting older, they'll just have to learn how to be babies longer.",
        author: "Andy Warhol"
      },
      {
        quote: "The true sign of intelligence is not knowledge but imagination.",
        author: "Albert Einstein"
        }].sample
  end

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
   tense_orientations = entries.pluck("tense_orientation").compact
   tense_mode = tense_orientations.mode
  end

  # def get_tense_mode(entries)
  #  # retrieves tense_orientation values and removes any nil values
  #  tense_orientations = entries.to_a.plucky("tense_orientation").compact
  #  tense_mode = tense_orientations.mode
  # end

  def return_relevant_entities(array_of_entries)
    all_relevant_entities = []
    array_of_entries.each do |entry|
      all_relevant_entities << entry.entities
    end
    all_relevant_entities.flatten!
  end

  def return_insights_hash(ents)
    insights_hash = {}
    insights_hash[:sample_size] = ents.size
    if ents.size == 0
      return insights_hash
    else
      insights_hash[:avg_mood] = ents.average("user_mood_input").truncate(2)
      insights_hash[:avg_word_count] = ents.average("word_count").truncate(2)
      insights_hash[:tense_mode] = get_tense_mode(ents)
      relevant_entities = return_relevant_entities(ents)
      # TODO I pushed all relavant entities into the :most_common_entities array. That's over kill.
      insights_hash[:most_common_entities] = relevant_entities.plucky("string_representation").uniq
      insights_hash
    end
  end #return insights_hash

  def filter_entries_by_time_written(array_of_entries, time_of_day)
    case time_of_day
    when "morning"
      return array_of_entries.morning
    when "afternoon"
      return array_of_entries.afternoon
    when "night"
      return array_of_entries.night
    else
      return array_of_entries
    end
  end # filter_entries_by_time_written

  def filter_entries_by_subject(array_of_entries, targeted_subject)
      return array_of_entries
  end # filter_entries_by_subject

end
