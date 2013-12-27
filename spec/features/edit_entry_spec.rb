require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!

# TODO write tests for the Entry Edit Feature

feature "Edit Entry" do

  context "when an entry has been validly updated" do

    it "should destroy entities associated with the entry"

  end # context - when an entry has been updated

  context "when a user attempts to update an entry with an invalid length" do

  end

end # feature Edit Entry
