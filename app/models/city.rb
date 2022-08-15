class City < ApplicationRecord
  belongs_to :user
  has_many :cars

  validates :flag_icon, presence: true
  validates :name, presence: true, uniqueness: true
end
