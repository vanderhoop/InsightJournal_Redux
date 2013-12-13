class WelcomeController < ApplicationController
  respond_to :json #sets all actions to respond to .json requests

  def index
    @entries = current_user.entries
  end

end
