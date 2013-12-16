class WelcomeController < ApplicationController
  respond_to :json #sets all actions to respond to .json requests

  def index
    # @entries = user_signed_in? ? current_user.entries.reverse.first(5) : nil
    @entries = user_signed_in? ? Entry.where(user_id: current_user.id).last(4).reverse : nil
  end

  def insights
    @overall_mood_score = avg_mood_score(current_user.entries)
    @avg_word_count = avg_word_count(current_user.entries)
    @most_common_tense = get_tense_mode(current_user.entries)
    binding.pry
  end

end
