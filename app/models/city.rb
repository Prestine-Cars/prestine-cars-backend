class City < ApplicationRecord
  belongs_to :user
  has_many :cars, dependent: :destroy

  validates :flag_icon, presence: true
  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }
end
