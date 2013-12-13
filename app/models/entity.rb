# == Schema Information
#
# Table name: entities
#
#  id                    :integer          not null, primary key
#  entry_id              :integer
#  string_representation :string(255)
#  count                 :integer
#  type                  :string(255)
#  sentiment_type        :string(255)
#  sentiment_score       :float
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Entity < ActiveRecord::Base
  attr_accessible :entry_id, :string_representation, :count, :type, :sentiment_type, :sentiment_score
  validates :entry_id, :string_representation, :presence => true
  validates_numericality_of :entry_id

  belongs_to :entry
end
