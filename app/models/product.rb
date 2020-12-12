class Product < ApplicationRecord
  belongs_to :store
  has_many_attached :photos
  monetize :price_cents

  searchkick
end
