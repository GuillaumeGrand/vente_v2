# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :store

  scope :find_order_validation_false, lambda{ |trader| where(store_id: trader.store.id, order_validation: false) }
  scope :find_current_user_orders, lambda{ |user| where(user_id: user.id).order! 'created_at DESC' }
  scope :find_order_validation_true, lambda{ |trader|  where(store_id: trader.store.id, order_validation: true) }
end
