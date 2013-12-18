require 'spec_helper'
require 'selenium-webdriver'

describe "The Home Page" do
  before(:each) do
    visit "/"
    @user = User.new
    @user.name = Faker::Name.name
    @user.email = Faker::Internet.email
    @user.password = "batman11"
    @user.password_confirmation = "batman11"
    @user.save
  end

  context "when users aren't signed in" do
    it "displays the sign in form" do
      expect(page).to have_css("form[action='/users/sign_in']")
    end

    it "won't display the logout button" do
      expect(page).to_not have_css("input[value='Log out']")
    end

    describe "signing in" do
      context "with the correct user name/pw for the first time", :js => true do
        it "takes you to the new user dashboard" do
          # binding.pry

          fill_in "Email", with: @user.email
          fill_in "Password", with: @user.password
          click_on "Sign in"
          expect(page).to have_content("Get Journaling")
        end
      end # with correct credentials
    end #signing in
  end # when users aren't signed in

  context "when users are signed in", :js => true do
    before(:each) do
      @user = User.new
      @user.name = Faker::Name.name
      @user.email = Faker::Internet.email
      @user.password = "batman11"
      @user.password_confirmation = "batman11"
      @user.save
      visit '/'
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_on "Sign in"
    end

    context "and have no entries" do
      describe "the insights page" do
        it "invites the user to start journaling" do
          click_on 'Insights'
          expect(page).to have_button("Get Journaling!")
        end
      end
    end

    # it "displays the user's most recent entries" do
    #   expect(page).to have_content("Entries")
    # end
  end # context - when users are signed in
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

