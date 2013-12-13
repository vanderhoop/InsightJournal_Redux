# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  dob                    :date
#  sex                    :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'spec_helper'

describe User do
  let(:user){User.new}

  # Active Record Methods ================================
  it "has a method to retrieve its entries in an array" do
    expect(user.entries.class).to eq(Array)
  end

  it "has a method to retrieve its entities in an array" do
    expect(user.entities.class).to eq(Array)
  end

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }

  it { should validate_uniqueness_of(:email) }
  # TODO devise created an additional attr_accessible, :remember_me,
  # to populate the sign in fields on an established user's computer.
  # Look up exactly what it's doing.

end
