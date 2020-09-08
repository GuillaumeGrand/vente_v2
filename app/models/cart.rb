class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :template
  belongs_to :product
end
