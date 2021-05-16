# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :store
  belongs_to :product

  scope :find_user_cart, lambda{ |user| where(user_id: user.id).order! 'created_at DESC' }
  scope :find_user_orders_in_store, -> { where(user_id: @user_id, store_id: @store_id) }
end
