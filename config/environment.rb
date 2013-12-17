# Load the rails application
require File.expand_path('../application', __FILE__)

class Array
  def mode
    sort_by {|i| grep(i).length }.last
  end

  def average(integer_column)
    sum = 0
    self.each do |entry|
      sum += entry[integer_column]
    end
    return sum/self.size
  end #average

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
