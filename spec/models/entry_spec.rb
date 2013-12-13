# == Schema Information
#
# Table name: entries
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  text                  :text
#  user_mood_input       :integer
#  lat                   :float
#  long                  :float
#  temperature           :integer
#  humidity              :float
#  word_count            :integer
#  most_common_adjective :string(255)
#  most_common_adverb    :string(255)
#  subject               :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'spec_helper'

describe Entry do
  before(:each) do
    @user = User.new
    @user.name = "Travis"
    @user.name = ""
  end

  let(:entry) { Entry.new }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:text)}
  it { should validate_presence_of(:user_mood_input)}

end


# describe Trainer do

#   let(:trainer) { Trainer.new }

#   # relying on rspec helpers
#   it "is invalid without a password idgest v2" do
#     expect(trainer).to have(1).error_on(:password_digest) # rspec helper
#   end

#   # cleanest, most readible and the most direct
#   it { should validate_presence_of(:password_digest) } # shoulda-matchers
#                                                        # https://github.com/thoughtbot/shoulda-matchers

#   it { should validate_presence_of(:email) }


#   it "can be created with a password, password_confirmation, and email set" do
#     trainer.password = "kickhash"
#     trainer.password_confirmation = "kickhash"
#     trainer.email = "kick@hash.com"
#     expect(trainer.save).to be_true
#   end

# end # describe Trainer
