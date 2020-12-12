class OrdersController < ApplicationController
  def dashboard
    current_trader.store ? @store = Store.find(current_trader.store.id) : ""
    @order = Order.where(:store_id => current_trader.store.id, :order_validation => false)
    @orders = @order.group_by(&:user_id)

    @amount = SumOrders.new(@orders).call
  end

  def validation_order
    orders_id = params[:cart].drop(1).flatten
    orders_id.each do |order_id|
    order = Order.find(order_id.to_i)
    order.order_validation
    order.order_validation = true
    order.save
  end

    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def show
  end
end
