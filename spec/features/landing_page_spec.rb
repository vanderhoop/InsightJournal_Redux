require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!

describe 'The Landing Page' do
  before(:each) do
    visit '/'
  end

    context "when users aren't logged in" do

      it "doesn't display the logout button" do
        expect(page).to_not have_css("input[value='Log out']")
      end

      it "doesn't display the Insights link" do
        page.has_no_link? "Insights"
      end

      it "doesn't display the Write link" do
        page.has_no_link?("Write")
      end

      it "displays the login form" do
        expect(page).to have_css("form[action='/users/sign_in']")
      end

    end # context - when users aren't logged in

end # describe - The Landing Page
