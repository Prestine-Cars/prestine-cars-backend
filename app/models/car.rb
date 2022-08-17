class Car < ApplicationRecord
  belongs_to :user
  belongs_to :city
  has_many :reservations

  validates :model, presence: true, length: { in: 3..50 }
  validates :photo, presence: true
  validates :cost, presence: true
end
