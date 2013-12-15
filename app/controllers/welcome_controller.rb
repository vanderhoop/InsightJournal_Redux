class WelcomeController < ApplicationController
  respond_to :json #sets all actions to respond to .json requests

  def index
    @entries = user_signed_in? ?  current_user.entries.reverse : nil
  end

end
