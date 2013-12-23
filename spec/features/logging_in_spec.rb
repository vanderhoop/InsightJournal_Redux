require 'spec_helper'
require 'selenium-webdriver'

include Warden::Test::Helpers
Warden.test_mode!

feature 'logging in' do

  describe 'the root url' do
    before(:each) do
      visit '/'
    end

    context "when users aren't logged in" do

      describe 'the login form' do

        it "is displayed" do
          expect(page).to have_css("form[action='/users/sign_in']")
        end

      end # describe - the login form

    end # context - when users aren't logged in

  end # describe - the root url

end # feature - logging in
