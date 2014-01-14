class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :user_instance
  before_filter :quotes

  require 'alchemy'

  def quotes
    @sampled_quote = {
          quote: "In order to understand the world, one has to turn away from it on occasion.",
          author: "Albert Camus"
        }
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
    insights_hash[:total_words] = current_user.entries.sum("word_count")
    if ents.size == 0
      insights_hash[:avg_mood] = "N/A"
      insights_hash[:avg_word_count] = "N/A"
      insights_hash[:tense_mode] = "N/A"
      return insights_hash
    else
      insights_hash[:avg_mood] = ents.average("user_mood_input").truncate(1).to_s + " out of 10"
      insights_hash[:avg_word_count] = ents.average("word_count").truncate(2)
      insights_hash[:tense_mode] = get_tense_mode(ents)
      relevant_entities = return_relevant_entities(ents)
      entities_by_string_rep = relevant_entities.group_by(&:string_representation)

      entity_storage_array = []
      # iterate through the entities by string_representation
      entities_by_string_rep.each do |entity|
        entity_storage_array << { subject: entity[0], count_total: entity[1].sum_entity_column("count"), most_common_sentiment: entity[1].plucky("sentiment_type").mode.capitalize, entity_type: entity[1].plucky("e_type").mode, entries: entity[1].plucky("entry_id") }
      end

      # TODO I pushed all relevant entities into the :most_common_entities array. That's over kill.
      entity_storage_array.sort_by! do |h|
        h[:count_total]
      end

      # entity_storage_array = entity_storage_array.to(7) if entity_storage_array.length > 7

      insights_hash[:most_common_entities] = entity_storage_array.reverse!

      # below I iterate through all relevant entities and push those that have a positive association into the positive_subjects key's value
      insights_hash[:positive_entities] = []
      entity_storage_array.each do |entity|
        insights_hash[:positive_entities] << entity if entity[:most_common_sentiment] == "Positive"
      end

      insights_hash[:negative_entities] = []
      entity_storage_array.each do |entity|
        insights_hash[:negative_entities] << entity if entity[:most_common_sentiment] == "Negative"
      end

      # binding.pry
      insights_hash[:humanity_sentiment] = nil
      insights_hash
    end
  end # insights_hash

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
