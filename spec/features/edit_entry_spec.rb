require 'spec_helper'
require 'selenium-webdriver'
include Warden::Test::Helpers

# TODO write tests for the Entry Edit Feature

feature "Edit Entry", :js => true do

  context "when an entry has been updated with a valid length" do
    before(:each) do
      Warden.test_reset!
      sign_up
      create_entry
      edit_last_entry(true)
    end

    it "the user is redirected to the Entry's show page" do
      expect(page).to have_link("Edit Entry")
    end

    it "should "

  end # context - when an entry has been updated

  context "when a user attempts to update an entry with too short a text" do
    before(:each) do
      Warden.test_reset!
      sign_up
      create_entry
      edit_last_entry(false)
    end

    # it "should not persist the entry as updated" do
    #   Entry.last.text
    # end

    it "should flash an error message" do
      expect(page).to have_content("Text is too short")
    end
  end

end # feature Edit Entry
