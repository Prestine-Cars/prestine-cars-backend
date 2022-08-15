class Car < ApplicationRecord
  belongs_to :user

  validates :model, presence: true, length: { in: 3..50 }
  validates :photo, presence: true
  validates :cost, presence: true
end
