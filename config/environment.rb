# Load the rails application
require File.expand_path('../application', __FILE__)

class Array
  def mode
    sort_by {|i| grep(i).length }.last
  end
end

# Initialize the rails application
InsightJournalRedux::Application.initialize!
