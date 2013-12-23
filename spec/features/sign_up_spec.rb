require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!

feature 'Signing Up', :js => true do

  context "when a user doesn't have an account" do

    describe 'the user_sign_up page' do
      before(:each) do
        Warden.test_reset!
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

        context "when passed valid credentials", :js => true do
          it "takes you to the new user dashboard" do
            fill_in "Email", with: "gijoe@gmail.com"
            fill_in "Password", with: "lovely"
            fill_in "Password confirmation", with: "lovely"
            page.has_link?("Get Journaling")
          end

        end # context - signing up w/ proper creditials

        context "when passed an invalid email" do
          before(:each) do
            fill_in "Email", with: "samantha@boyd"
            fill_in "Password", with: "samantha"
            fill_in "Password confirmation", with: "samantha"
          end

          it "rerenders the sign up page" do
            page.has_field?("Password confirmation")
          end

          it "flashes an error message" do
            page.has_text?("Email invalid")
          end
        end # context - "when passed an invalid email"

        context "when pw doesn't match pw confirmation" do
          before(:each) do
            fill_in "Email", with: "sam.eldred@gmail.com"
            fill_in "Password", with: "Uruguay"
            fill_in "Password confirmation", with: "Baseball"
          end

          it "rerenders the sign up page" do
            page.has_field?("Password confirmation")
          end

          it "flashes an error message" do
            page.has_text?("match")
          end

        end # context - when pw doesn't match pw confirmation

        context "when pw and pw confirmation < 6 characters" do
          before(:each) do
            fill_in "Email", with: "tonymcgibbon@yahoo.com"
            fill_in "Password", with: "small"
            fill_in "Password confirmation", with: "small"
          end

          it "rerenders the sign up page" do
            page.has_field?("Password confirmation")
          end

          it "flashes an error message" do
            page.has_text?("minimum")
          end

        end # context - when pw and pw confirmation < 6 characters

      end # describe - the user_sign_up form

    end # describe - the user_sign_up page

  end # context - when a user doesn't have an account

end # feature - Signing Up

describe "The Root URL" do
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

  #   it "should link to the insights page" do
  #     page.has_link?("Insights")
  #   end

  #   it "should link to the new entry action" do
  #     page.has_link?("Write")
  #   end

  #   it "should display a log out button" do
  #     page.has_link?("Log out")
  #   end

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

