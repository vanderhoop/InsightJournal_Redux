module CapybaraAbstractions

  def sign_up
    visit '/'
    fill_in "user_email_sign_up", with: Faker::Internet.email
    fill_in "user_password_sign_up", with: "yearofbirth"
    fill_in "user_password_confirmation_sign_up", with: "yearofbirth"
    page.find("input[value='Sign Up']").click
  end

  def create_entry
    click_on "Write"
    fill_in "entry_text", with: "There's a whole lot of shakin' goin' on. Jim Belushi would be proud!"
    page.find("#create-entry").click
  end

  def edit_last_entry(valid_edit)
    entry_id = Entry.last.id
    visit "/users/1/entries/#{entry_id}"
    click_on "Edit Entry"
    new_text = valid_edit ? "Everything about Brett Favre now makes me sick. If only he had the integrity of a Michael Jordan or an Abraham Lincoln." : "Derp!"
    fill_in "entry_text", with: new_text
    find("option[value='6']").click
    find("#update-entry").click
  end

end

RSpec.configure do |config|
  config.include CapybaraAbstractions, :type => :feature
end
