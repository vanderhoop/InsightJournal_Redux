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
#  tense_orientation     :string(255)

require 'spec_helper'

describe Entry do
  before(:each) do
    @user = User.new
    @user.name = "Joe"
    @user.email = "joe@joes.com"
    @user.password = "batman21"
    @user.password_confirmation = "batman21"
    @user.save
  end

  let(:entry) { Entry.new }

  it { should validate_numericality_of(:user_id) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:hour_created) }
  it { should validate_numericality_of(:hour_created) }
  it { should validate_presence_of(:user_mood_input) }
  it { should validate_presence_of(:word_count) }
  it { should validate_numericality_of(:word_count) }
  it { should ensure_length_of(:text).is_at_least(10) }

  it 'can be created with a valid user_id, text, user_mood_input, and word count' do
    new_entry = entry
    new_entry.user_id = 1
    new_entry.text = "Everything about the Minnesota Vikings is rotten."
    new_entry.user_mood_input = 4
    new_entry.word_count = 10
    new_entry.set_hour_created
    expect(new_entry.save).to be_true
  end

  describe "before save" do
    before(:each) do
      @unsaved_entry = entry
    end

  end # before save

end # describe Entry
