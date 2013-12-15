# == Schema Information
#
# Table name: entities
#
#  id                    :integer          not null, primary key
#  entry_id              :integer
#  string_representation :string(255)
#  count                 :integer
#  e_type                :string(255)
#  sentiment_type        :string(255)
#  sentiment_score       :float
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'spec_helper'

describe Entity do

  it "can be instantiated" do
    entity = Entity.new
    expect(entity.class).to be(Entity)
  end

  it { should validate_presence_of(:entry_id) }
  it { should validate_presence_of(:string_representation) }
  it { should allow_mass_assignment_of(:entry_id) }
  it { should allow_mass_assignment_of(:string_representation) }
  it { should allow_mass_assignment_of(:count) }
  it { should allow_mass_assignment_of(:e_type) }
  it { should allow_mass_assignment_of(:sentiment_type) }
  it { should allow_mass_assignment_of(:sentiment_score) }

  it {should validate_numericality_of(:entry_id) }

  # :entry_id, :string_representation, :count,
  # :type, :sentiment_type, :sentiment_score



end

# require 'spec_helper'

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

