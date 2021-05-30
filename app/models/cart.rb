# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :store
  belongs_to :product

  scope :find_user_cart, lambda{ |user| where(user_id: user.id).includes(:store, [product: [photos_attachments: :blob]]).order! 'created_at DESC' }
  scope :find_user_orders_in_store, lambda{ |user_id, store_id| where(user_id: user_id, store_id: store_id) }
end
