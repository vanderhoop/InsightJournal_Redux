require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!
Warden.test_reset!

feature "New Entry Creation" do

  before(:each) do
    @user = User.new
    @user.name = "Bob Joe"
    @user.email = Faker::Internet.email
    @user.password = "batman11"
    @user.password_confirmation = "batman11"
    @user.save
    login_as(@user, :scope => :user)
    visit "/users/#{@user.id}/entries/new"
  end

  context "when users write an entry > 10 characters" do
    before(:each) do
      fill_in "entry_text", with: "Marp de darp de darp de doo"
    end

    it "persists the entry to the db" do

    end

  end # context - when users create an entry > 10 characters

  context "when users create an entry < 10 chars" do
    before(:each) do
      fill_in "entry_text", with: "shorty"
      click_on "Create Entry"
    end

    it "rerenders the new entry page" do
      page.has_css?("input[value='Create Entry']")
    end

    it "displays an entry-length error" do
      page.has_text?("Your entry was only")
    end
  end # context - when users create an entry < 10 chars

end # feature - New
