require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!

feature 'The Login Process', :js => true do

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

  context "when the user enters valid credentials" do
    before(:each) do
      fill_in "Email", with: "bobbyjoe@marpdarp.com"
      fill_in "Password", with: "batman11"
      click_on "Sign in"
    end

    it "welcomes the user to their dashboard" do
      expect(page).to have_content("You're in!")
    end

    it "allows the user to sign out" do
      click_on "Log out"
      expect(page).to have_content("Goodbye from the team at InsightJournal")
    end

  end # context - when the user enters valid credentials

  context "when the user enters the wrong password" do
    before(:each) do
      fill_in "Email", with: "bobbyjoe@marpdarp.com"
      fill_in "Password", with: "batman99"
      click_on "Sign in"
    end

    it "rerenders the sign in page" do
      page.has_field?("Password")
    end

    it "flashes an incorrect creditials error" do
      page.has_text?("Invalid email or password")
    end

  end # context - when passed the wrong password

  context "when the user enters the wrong email address" do
    before(:each) do
      fill_in "Email", with: "humpty@dumpty.com"
      fill_in "Password", with: "humptysPass"
      click_on "Sign in"
    end

    it "rerenders the sign in page" do
      page.has_css?("form[action='/users/sign_in']")
    end

    it "flashes an incorrect credentials error" do
      page.has_content?("Invalid email or password")
    end

  end # context - when passed an email unassociated with a user

end # feature - logging in
