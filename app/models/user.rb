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
