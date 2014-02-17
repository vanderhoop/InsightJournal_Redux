# Load the rails application
require File.expand_path('../application', __FILE__)

def most_common_value(arr)
  value_appearances = arr.group_by do |e|
                        e
                      end
  return "N/A" if value_appearances.values.max_by(&:size).nil?
  value_appearances.values.max_by(&:size).first
end

# Initialize the rails application
InsightJournalRedux::Application.initialize!
