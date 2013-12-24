class WelcomeController < ApplicationController
  respond_to :json #sets all actions to respond to .json requests
  before_filter :user_signed_in?

  def index
    @entries = user_signed_in? && current_user.entries.size > 0 ? Entry.where(user_id: current_user.id).last(5).reverse : []
  end

  def insights
    if user_signed_in?
      @insights = return_insights_hash(current_user.entries)
    end
  end

  def new_insights
    time_filtered_entries = filter_entries_by_time_written(current_user.entries, params["timeOfDay"])
    subject_filtered_entries = filter_entries_by_subject(time_filtered_entries, params["properNouns"])
    @new_insights = return_insights_hash(time_filtered_entries)

    respond_to do |format|
      format.json do
        render json: @new_insights
      end
    end
  end # new_insights

end


