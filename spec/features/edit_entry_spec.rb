require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!

# TODO write tests for the Entry Edit Feature

feature "Edit Entry" do

  context "when an entry has been updated with a valid length" do
    before(:each) do
      sign_up
      create_entry
    end

    # it "should destroy entities associated with the entry"

  end # context - when an entry has been updated

  context "when a user attempts to update an entry with an invalid length" do
    # it "should not persist the entry as updated"
    # it "should flash an error message"
  end

end # feature Edit Entry
