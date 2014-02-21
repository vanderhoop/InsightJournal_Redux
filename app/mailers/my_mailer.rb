class MyMailer < ActionMailer::Base
  default from: "welcome@insightjournal.us"

  def new_user(user)
    @user = user
    @email = @user.email
    mail to: @email, subject: "Welcome to InsightJournal!"
  end

end
