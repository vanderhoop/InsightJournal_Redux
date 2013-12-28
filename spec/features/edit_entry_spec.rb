require 'spec_helper'
require 'selenium-webdriver'
include Warden::Test::Helpers

# TODO write tests for the Entry Edit Feature

feature "Editing An Entry", :js => true do
  before(:each) do
    Warden.test_reset!
    sign_up
    create_entry
  end

  context "when a user attempts to edit an entry with valid length" do
    before(:each) do
      edit_last_entry(true)
    end

    it "the user is redirected to the Entry's show page" do
      expect(page).to have_link("Edit Entry")
    end

  end # context - when an entry has been updated

  context "when a user shortens an entry to < 10 chars" do
    before(:each) do
      edit_last_entry(false)
    end

    it "rerenders the edit page" do
      expect(page). to have_css("input[value='Update Entry']")
    end

    it "should flash an error message" do
      expect(page).to have_content("Text is too short")
    end

  end # context - when an entry has been updated

end # feature Edit Entry
