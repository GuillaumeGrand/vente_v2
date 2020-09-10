class Store < ApplicationRecord
  has_one_attached :photos
  validates :photos, presence: true
  belongs_to :trader
  has_many :products
end
