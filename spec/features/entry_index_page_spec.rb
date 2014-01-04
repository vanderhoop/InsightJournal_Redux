require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Entries Index Page', :js => true do
  before(:each) do
    sign_up
  end

  context "when a user has entries" do

    before(:each) do
      create_entry
      visit '/'
    end

    # TODO write a more relevant test for the entries#index page

    it "renders an archive header" do
      click_on "Archive"
      expect(page).to have_content("Archive")
    end

  end # context - when a user has entries

  context "when a user hasn't written an entry" do
    # it "should tell them they shouldn't be there"

  end # context - when a user hasn't written an entry

end # describe - Entries Index Page
