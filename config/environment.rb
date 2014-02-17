# Load the rails application
require File.expand_path('../application', __FILE__)

class Array
  def mode
    mode = sort_by {|i| grep(i).length }.last
    if mode
      mode
    else
      "N/A"
    end
  end

  def plucky(column_name)
    new_array = []
    self.select do |entry|
      new_array << entry[column_name]
    end
    new_array
  end
end

# Initialize the rails application
InsightJournalRedux::Application.initialize!
