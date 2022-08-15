class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :date, presence: true
end
