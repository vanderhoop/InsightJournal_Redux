require 'spec_helper'
require 'selenium-webdriver'
include Warden::Test::Helpers

feature "Entry Deletion" do
  before(:each) do
    Warden.test_reset!
    sign_up
    create_entry
    entry_id = Entry.last.id
    visit "/users/1/entries/#{entry_id}"
  end

  context "when the user clicks delete entry link", :js => true do
    before(:each) do
      page.evaluate_script('window.confirm = function() { return true; }')
      click_on "Delete Entry"
    end

    it "flashes a success message" do
      expect(page).to have_content("Your entry was erased.")
    end

    it "takes the user back to the user dashboard" do
      dashboard_text = User.last.entries.size > 0 ? "Recent Entries:" : "Welcome to InsightJournal!"
      expect(page).to have_content(dashboard_text)
    end

  end # context - when the user clicks delete entry link


end # feature - Entry Deletion
