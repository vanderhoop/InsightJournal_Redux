require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!

describe 'InsightJournal', :js => true do

  context "when a user doesn't have an account" do
     describe "signing up" do
      it "is displayed as a linked option at the root url" do
        visit '/'
        expect(page).to have_link("Sign up")
      end

      describe 'the user_sign_up page' do
        before(:each) do
          visit '/users/sign_up'
        end

        it "has a sign up form" do
          expect(page).to have_css("form[action='/users']")
        end

        describe "the user sign up form" do

          it "takes an email" do
            page.has_field? 'Email'
          end

          it "takes a password" do
            page.has_field? 'Password'
          end

          it "takes a password confirmation" do
            page.has_field? "Password Confirmation"
          end

          context "when passed valid creditials", :js => true do
            it "takes you to the new user dashboard" do
              fill_in "Email", with: "gijoe@gmail.com"
              fill_in "Password", with: "lovely"
              fill_in "Password confirmation", with: "lovely"
              page.has_link?("Get Journaling")
            end

          end # context - signing up w/ proper creditials

          context "when passed an invalid email" do
            it "flashes an "
          end # context - "when passed an invalid email"

        end # describe - the user_sign_up form

      end # describe - the user_sign_up page

    end # describe - signing up

  end # context - when a user doesn't have an account

end # InsightJournal

describe "The Root URL" do
  before(:each) do
    visit "/"
  end

  context "when users aren't signed in" do
    it "displays the sign in form" do
      expect(page).to have_css("form[action='/users/sign_in']")
    end

    it "doesn't display the logout button" do
      expect(page).to_not have_css("input[value='Log out']")
    end

    it "doesn't display the insights link" do
      page.has_no_link? "Insights"
    end

    it "doesn't display the Write link" do
      page.has_no_link?("Write")
    end

    describe "signing in" do
    end # describe - signing in

  end # context - when users aren't signed in

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
      page.has_link?("Log out")
    end

    it "allows users to visit their insights page" do
      click_on "Insights"
      page.has_text?("page")
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

end # describe "The Root URL"

