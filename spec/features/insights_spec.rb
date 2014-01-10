require 'spec_helper'
require 'selenium-webdriver'

describe "The Insights Page", :js => true do
  before(:each) do
    sign_up
  end

  context "when a user has no entries" do
    before(:each) do
      click_on "Insights"
    end

    it "displays no insights" do
      page.has_no_text?("out of 10")
    end

    it "invites the user to start journaling" do
      page.has_link?("Get Journaling!")
    end

  end # context - when a user has no entries

  context "when a user has one or more entries" do
    before(:each) do
      create_entry
      click_on "Insights"
    end

    it "displays insights" do
      expect(page).to have_content("Subjects")
      click_on "Log Out"
    end

  end # context - when a user has entries

end # describe - The Insights Page
