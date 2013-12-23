require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!

feature 'Logging In', :js => true do

  context "when users aren't logged in" do

      before(:each) do
        Warden.test_reset!
        visit '/'
      end

      it "displays the login form" do
        expect(page).to have_css("form[action='/users/sign_in']")
      end

  end # context - when users aren't logged in

end # feature - logging in
