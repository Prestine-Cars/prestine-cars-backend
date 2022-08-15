class City < ApplicationRecord
  belongs_to :user

  validates :flag_icon, presence: true
  validates :name, presence: true, uniqueness: true
end
