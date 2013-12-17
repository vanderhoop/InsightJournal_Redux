class WelcomeController < ApplicationController
  respond_to :json #sets all actions to respond to .json requests

  def index
    binding.pry
    # @entries = user_signed_in? ? current_user.entries.reverse.first(5) : nil
    @entries = user_signed_in? ? Entry.where(user_id: current_user.id).last(4).reverse : nil
  end

  def insights
    @insights = return_insights_hash(current_user.entries)
  end

  def new_insights
    # time_of_day_desired = params["timeOfDay"]
    time_filtered_entries = filter_entries_by_time_written(current_user.entries.to_a, params["timeOfDay"])
    @new_insights = return_insights_hash(time_filtered_entries)

    respond_to do |format|
      format.json do
        render json: @new_insights
      end
    end
    #respond with @time_filtered_entries as JSON.
  end # new_insights

end


