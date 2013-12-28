require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!
Warden.test_reset!

feature "Filtering Insights" do
  before(:each) do
    sign_up
    create_entry
    click_on "Insights"
  end

  context "when a user has one or more entries", :js => true do
    it "changes the appearance of the Insights page" do
      hour_mark = Entry.last.hour_created
      expect(page).to_not have_content("N/A")
      time_filter = hour_mark == (13..17) ? "morning" : "afternoon"
      find("option[value=#{time_filter}]").click
      find("#filter-btn").click
      expect(page).to have_content("N/A")
    end
  end # context - when a user has one or more entries

end
