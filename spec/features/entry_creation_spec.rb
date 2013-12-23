require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!
Warden.test_reset!

feature "New Entry Creation" do

  before(:each) do
    @user = User.new
    @user.name = "Bob Joe"
    @user.email = "bobbyjoe@marpdarp.com"
    @user.password = "batman11"
    @user.password_confirmation = "batman11"
    @user.save
    login_as(@user, :scope => :user)
    visit new_user_entry_path
  end

  context "when users create an entry > 10 characters" do
    before(:each) do
      fill_in "entry_text", with: "Marp de darp de darp de doo"
    end

    #"displays their results"

  end # context - when users create an entry > 10 characters

  context "when users create an entry < 10 chars" do
    #it "rerenders the new entry page"
  end # context - when users create an entry < 10 chars

end # feature - New
