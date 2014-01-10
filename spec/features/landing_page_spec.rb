require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!

describe 'The Landing Page', :js => true do
  before(:each) do
    visit '/'
  end

  context "when users aren't logged in" do

    it "links to a sign up page" do
      page.has_link?("Sign up")
    end

    it "doesn't display the logout button" do
      expect(page).to_not have_css("input[value='Log Out']")
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

      describe 'the login form' do

        it "has an 'Email' text input" do
          page.has_field?("Email")
        end

        it "has a 'Password' text input" do
          page.has_field?("Password")
        end

      end # describe - the login form

  end # context - when users aren't logged in

end # describe - The Landing Page
