# Load the rails application
require File.expand_path('../application', __FILE__)

class Array
  def mode
    sort_by {|i| grep(i).length }.last
  end

  # def average(integer_column)
  #   sum_num = 0
  #   self.each do |entry|
  #     sum_num += entry[integer_column]
  #   end
  #   return sum_num/self.size
  # end #average

  def sum_entity_column(column_name)
    sum = 0
    self.each do |entity|
      sum += entity[column_name]
    end
    sum
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
