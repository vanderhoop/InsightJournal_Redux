class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :user_instance

  require 'alchemy'

  def user_instance
    @user = current_user
  end

  def get_relations(text)
    alchemy_api = Alchemy.new()
    relations = alchemy_api.relations('text', text)["relations"]
    tenses = []
    relations.each do |relation|
      tenses << relation["action"]["verb"]["tense"]
    end
    tenses.mode
  end

end
