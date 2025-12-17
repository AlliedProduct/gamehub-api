class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :reviews, dependent: :destroy
  has_many :library_items, dependent: :destroy
  has_many :games, through: :library_items

  validates :username, presence: true, uniqueness: true
end
