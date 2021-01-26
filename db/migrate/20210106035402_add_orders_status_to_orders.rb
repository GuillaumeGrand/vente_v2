# frozen_string_literal: true

class AddOrdersStatusToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :order_status, :string
  end
end
