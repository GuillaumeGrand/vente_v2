class OrdersController < ApplicationController
  def dashboard
    current_trader.store ? @store = Store.find(current_trader.store.id) : ""
    @order = Order.where(:store_id => current_trader.store.id)
    @orders = @order.group_by(&:user_id)

    @amount = SumOrders.new(@orders).call
  end

  def show
  end
end
