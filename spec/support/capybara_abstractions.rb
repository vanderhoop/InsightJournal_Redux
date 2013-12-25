module CapybaraAbstractions

  def sign_up
    visit '/users/sign_up'
    fill_in "Email", with: "capybara1987@hotmail.com"
    fill_in "Password", with: "yearofbirth"
    fill_in "Password confirmation", with: "yearofbirth"
    page.execute_script("$('form#new_user').submit()")
  end

  def create_entry
    click_on "Write"
    fill_in "entry_text", with: "There's a whole lot of shakin' goin' on."
    page.find("#create-entry").click
  end

end

RSpec.configure do |config|
  config.include CapybaraAbstractions, :type => :feature
end
