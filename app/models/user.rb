class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
        #  :recoverable, :rememberable, :validatable
  # devise :omniauthable, omniauth_providers: %i[keycloakopenid]
    has_many :messages
    validates_uniqueness_of :username
    scope :all_except, ->(user) { where.not(id: user) }
    after_create_commit { broadcast_append_to "users" }
end
