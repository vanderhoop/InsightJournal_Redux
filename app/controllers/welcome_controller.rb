class WelcomeController < ApplicationController
  respond_to :json #sets all actions to respond to .json requests

  def index
    # @entries = user_signed_in? ? current_user.entries.reverse.first(5) : nil
    @entries = user_signed_in? ? Entry.where(user_id: current_user.id).last(4).reverse : nil
  end

end
