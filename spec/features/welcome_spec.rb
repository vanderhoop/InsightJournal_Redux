require 'spec_helper'

describe "The Home Page" do
  before(:each) do
    visit "/"
  end

  describe Session do
    context "when users aren't signed in" do
        it "displays the landing page" do
          fill_in

        end

    end # describe "The Home Page"
  end #describe Session

end # describe "The Home Page"

# require 'spec_helper'

# describe "visiting the homepage" do

#   it "displays the homepage" do
#     visit '/'
#     expect(page).to have_css("#welcome")
#   end

#   it "has a link to the about page" do
#     visit '/'
#     expect(page.find('a[href="/about"]')).to be_true
#   end

#   it "says the Overlook Hotel" do
#     visit '/'
#     expect(page).to have_content("Overlook Hotel")
#   end

#   it "takes us to the about page" do
#     visit '/'
#     # find('a[href="/about"]').click
#     click_on 'About us'
#     expect(page).to have_css("img[src='overlook.png']")
#     expect(page).to have_css("h1#about_us")
#     save_and_open_page
#   end

#   #js: true ensures we run the tests with javascript
#   describe "registering for the hotel", js: true do
#     before(:each) {visit root_path}

#     it "registers a user with ajax" do
#       click_on "Register"
#       expect(page).to have_content "Registration Form"
#       fill_in "Name", with: "Jack"
#       click_button "register"
#       expect(page).to have_content "Welcome, Jack"
#     end

#   end #describing registering for the hotel

# end # describe visiting the homepage

