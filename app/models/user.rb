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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :entries
  has_many :entities, :through => :entries
end

# class User < ActiveRecord::Base
#   attr_accessible :name, :email, :password, :password_confirmation
#   has_secure_password
#   validates :name, :email, :password, :password_confirmation, :presence => true
#   validates :email, :uniqueness => true
#   validates :password, :password_confirmation, :length => { in: 4..20 }

#   has_many :entries
#   has_many :ideas, :through => :entries
# end
