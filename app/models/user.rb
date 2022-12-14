class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cities
  has_many :cars
  has_many :reservations

  validates :name, presence: true, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: true
end
