require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!

feature 'Logging In', :js => true do

  context "when user isn't logged in" do
    before(:each) do
      Warden.test_reset!
      @user = User.new
      @user.name = "Bob Joe"
      @user.email = "bobbyjoe@marpdarp.com"
      @user.password = "batman11"
      @user.password_confirmation = "batman11"
      @user.save
      visit '/'
    end

    it "displays the login form" do
      expect(page).to have_css("form[action='/users/sign_in']")
    end

    describe 'the login form' do

      it "has an 'Email' text input" do
        page.has_field?("Email")
      end

      it "has a 'Password' text input" do
        page.has_field?("Password")
      end

      context "when passed the wrong password" do
        before(:each) do
          fill_in "Email", with: "bobbyjoe@marpdarp.com"
          fill_in "Password", with: "batman99"
          click_on "Sign in"
        end

        it "rerenders the sign up page" do
          page.has_field?("Password")
        end

        it "flashes an incorrect creditials error" do
          page.has_text?("Invalid email or password")
        end

      end # context - when passed the wrong password

      context "when passed an email unassociated with a user" do
        before(:each) do
          fill_in "Email", with: "humpty@dumpty.com"
          fill_in "Password", with: "humptysPass"
          click_on "Sign in"
        end

        it "rerenders the sign up page" do
          page.has_css?("form[action='/users/sign_in']")
        end

        it "flashes an incorrect credentials error" do
          page.has_text?("Invalid email or password")
        end
      end # context - when passed an email unassociated with a user

    end # describe - the login form

  end # context - when users aren't logged in

end # feature - logging in
