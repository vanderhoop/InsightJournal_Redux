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
      visit "/users/#{@user.id}/entries/new"
      fill_in "entry_text", with: "Michael Jackson was my favorite musician, but he abused kids, so not anymore."
      page.find("#create-entry").click
      page.has_text?("Subjects")
    end
  end # context - when a user has entries

end # describe - The Insights Page
