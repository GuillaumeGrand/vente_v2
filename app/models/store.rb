# frozen_string_literal: true

class Store < ApplicationRecord
  has_one_attached :photos
  validates :photos, presence: true
  belongs_to :trader
  has_many :products, dependent: :destroy
  has_many :orders

  searchkick
end
