# frozen_string_literal: true

class AddOrderValidationToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :order_validation, :boolean, default: false
  end
end
