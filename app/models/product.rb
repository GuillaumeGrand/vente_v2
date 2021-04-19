# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :store
  has_many_attached :photos
  monetize :price_cents

  searchkick

  def first_product_photo
    photos[0].key
  end
end
