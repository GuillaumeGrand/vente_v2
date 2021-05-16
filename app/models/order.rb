# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :store

  scope :find_order_validation_false, -> { where(store_id: current_trader.store.id, order_validation: false) }
  scope :find_current_user_orders, -> { where(user_id: current_user.id).order! 'created_at DESC' }
  scope :find_order_validation_true, -> { store_id: current_trader.store.id, order_validation: true }
end
