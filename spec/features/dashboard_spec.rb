require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!

describe "The User Dashboard" do
  before(:each) do
    visit "/"
  end

  context "when users are signed in", :js => true do
    before(:each) do
      @user = User.new
      @user.name = "Bob Joe"
      @user.email = Faker::Internet.email
      @user.password = "batman11"
      @user.password_confirmation = "batman11"
      @user.save
      login_as(@user, :scope => :user)
    end

    it "should link to the insights page" do
      page.has_link?("Insights")
    end

    it "should link to the new entry action" do
      page.has_link?("Write")
    end

    it "should display a log out button" do
      page.has_link?("Log Out")
    end

    context "when users have no entries" do

      it "should display the welcome message" do
        page.has_text?("Welcome to InsightJournal!")
      end

      it "should invite users to write their first entry" do
        page.has_link?("Get Journaling")
      end

    end # context - users have no entries

    context "when users have written entries" do
      before(:each) do
        @entry = Entry.new
        @entry.text = "I'm in love with (nearly) all things relating to the Green Bay Packers"
        @entry.user_mood_input = 8
        @entry.word_count = @entry.text.get_word_count
        @user.entries << @entry
      end

      it "should display the first 90 characters of the last entry" do
        page.has_text?("I'm in love with (nearly) all things relating to the Green Bay Packers")
      end

      it "should not have a Get Journaling link" do
        page.has_no_link?("Get Journaling")
      end

    end # context - users have written entries

  end # context - when users are signed in

end # describe "The User Dashboard"
