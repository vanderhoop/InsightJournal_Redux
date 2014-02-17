module EntryUtils
  require 'alchemy'

  def most_common_value(arr)
    value_appearances = arr.group_by { |e| e }
    return "N/A" if value_appearances.values.max_by(&:size).nil?
    value_appearances.values.max_by(&:size).first
  end

  def get_relations(text)
    alchemy_api = Alchemy.new()
    relations = alchemy_api.relations('text', text)["relations"]
    tenses = relations.map do |relation|
      relation["action"]["verb"]["tense"]
    end
    most_common_value(tenses)
  end

  def get_tense_mode(entries)
   # collects all tense_orientations, throws them in an array
   tense_orientations = entries.pluck("tense_orientation").compact
   tense_mode = most_common_value(tense_orientations)
  end

  def largest_hash_key(hash)
    array_of_key_and_value = hash.max_by{ |k,v| v }
    key = array_of_key_and_value[0]
  end

  def return_most_common_writing_time
    comparison_hash = {
      "morning" => current_user.entries.morning.sum("word_count"),
      "afternoon" => current_user.entries.afternoon.sum("word_count"),
      "evening" => current_user.entries.night.sum("word_count")
    }
    most_common_writing_time = largest_hash_key(comparison_hash)
  end

  def return_relevant_entities(array_of_entries)
    all_relevant_entities = array_of_entries.map { |entry| entry.entities }
    all_relevant_entities.flatten!
  end

  def return_insights_hash(ents)
    insights_hash = {
      :sample_size => ents.size,
      :total_words => current_user.entries.sum("word_count")
    }

    if ents.size == 0
      insights_hash[:avg_mood] = "N/A"
      insights_hash[:avg_word_count] = "N/A"
      insights_hash[:tense_mode] = "N/A"
      insights_hash
    else
      insights_hash[:avg_mood] = ents.average("user_mood_input").truncate(1).to_s + " out of 10"
      insights_hash[:avg_word_count] = ents.average("word_count").truncate(2)
      insights_hash[:tense_mode] = get_tense_mode(ents)
      insights_hash[:most_common_writing_time] = return_most_common_writing_time
      relevant_entities = return_relevant_entities(ents)

      person_entities = relevant_entities.select { |entity| entity[:e_type] == "Person" }

      # I want to count the numer of negative, positive, and neutral
      # associations and take the one that appears the most.
      comparison_hash = {
        "positive" => person_entities.select { |person| person[:sentiment_type] == "positive" }.length,
        "negative" => person_entities.select { |person| person[:sentiment_type] == "negative" }.length,
        "neutral"  => person_entities.select { |person| person[:sentiment_type] == "neutral"  }.length
      }

      # largest_hash_key tells me which of the sentiments appears most often
      insights_hash[:humanity_sentiment] = largest_hash_key(comparison_hash)

      entities_by_string_rep = relevant_entities.group_by(&:string_representation)

      # iterate through the entities by string_representation
      entity_storage_array = entities_by_string_rep.map do |entity|
        {
          subject: entity[0],
          count_total: entity[1].map { |e| e[:count] }.reduce(:+),
          most_common_sentiment: most_common_value(entity[1].map { |e| e["sentiment_type"] }).capitalize,
          entity_type: most_common_value(entity[1].map { |e| e["e_type"] }),
          entries: entity[1].map { |e| e["entry_id"] }
        }
      end

      # TODO I pushed all relevant entities into the :most_common_entities array. That's over kill.
      entity_storage_array.sort_by! { |h| h[:count_total] }

      insights_hash[:most_common_entities] = entity_storage_array.reverse!
      insights_hash[:positive_entities] = entity_storage_array.select { |entity| entity[:most_common_sentiment] == "Positive" }
      insights_hash[:negative_entities] = entity_storage_array.select { |entity| entity[:most_common_sentiment] == "Negative" }
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
    array_of_entries
  end # filter_entries_by_subject

end # EntryUtils
