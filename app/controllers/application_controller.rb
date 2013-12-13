class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :user_instance

  def user_instance
    @user = current_user
  end
end
