require 'spec_helper'
require 'selenium-webdriver'

Warden.test_mode!

feature "New Entry Creation" do

  before(:each) do
    Warden.test_reset!
    sign_up
    click_on "Write"
  end

  context "when users write an entry > 10 characters" do
    before(:each) do
      fill_in "entry_text", with: "Marp de darp de darp de doo"
    end

    it "persists the entry to the db" do
      num_entries_before_click = Entry.last == nil ? 0 : Entry.last.id
      page.find("#create-entry").click
      expect(Entry.last.id).to eq(num_entries_before_click + 1)
    end

  end # context - when users create an entry > 10 characters

  context "when users create an entry < 10 chars" do
    before(:each) do
      fill_in "entry_text", with: "shorty"
    end

    it "rerenders the new entry page" do
      click_on "Create Entry"
      page.has_css?("input[value='Create Entry']")
    end

    it "displays an entry-length error" do
      page.has_text?("Your entry was only")
    end

  end # context - when users create an entry < 10 chars

end # feature - New
