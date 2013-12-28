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

  context "when the user clicks delete entry link" do
    before(:each) do
      page.evaluate_script('window.confirm = function() { return true; }')
      click_on "Delete Entry"
    end

    # it "the browser will ask the user to confirm their decision" do
    #   page.driver.browser.switch_to.alert.accept
    # end

    context "when the user confirms their decision", :js => true do
      before(:each) do
        # page.driver.action.key_down(:enter).key_up(:enter)
      end

      it "flashes a success messages" do
        expect(page).to have_content("Your entry was erased.")
      end
    end

  end


end # feature - Entry Deletion
