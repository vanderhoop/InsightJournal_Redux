require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!
Warden.test_reset!

describe "The Insights Page", :js => true do
  before(:each) do
    @user = User.new
    @user.name = "Errthang Mybaby"
    @user.email = Faker::Internet.email
    @user.password = "slurpDerp"
    @user.password_confirmation = "slurpDerp"
    @user.save
    login_as(@user, :scope => :user)
  end

  context "when a user has no entries" do
    before(:each) do
      visit "/users/#{@user.id}/insights"
    end

    it "displays no insights" do
      page.has_no_text?("out of 10")
    end

    it "invites the user to start journaling" do
      page.has_link?("Get Journaling!")
    end

  end # context - when a user has no entries

  context "when a user has one or more entries" do
    it "displays insights" do
      Warden.test_reset!
      visit '/'
      click_on "Sign up"
      fill_in "Email", with: "Devise@hasfailings.com"
      fill_in "Password", with: "deviser"
      fill_in "Password confirmation", with: "deviser"
      page.execute_script("$('form#new_user').submit()")
      click_on "Get Journaling"
      fill_in "entry_text", with: "Michael Jackson used to be my favorite musician. Not anymore."
      page.find("#create-entry").click
      expect(page).to have_content("Subjects")
      click_on "Log out"
    end
  end # context - when a user has entries

end # describe - The Insights Page
