class OrdersController < ApplicationController
  def dashboard
    current_trader.store ? @store = Store.find(current_trader.store.id) : ""

    if current_trader.store != nil
      @order = Order.where(:store_id => current_trader.store.id, :order_validation => false)
      @orders = @order.group_by(&:user_id)
    else
      @orders = []
    end

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

  def user_show
     orders = Order.where(:user_id => current_user.id).order! 'created_at DESC'
     @stores_orders = orders.group_by(&:store_id)
  end

  def history
    @order = Order.where(:store_id => current_trader.store.id, :order_validation => true)
    @orders = @order.group_by(&:user_id)

    respond_to do |format|
      format.js {render layout: false} # Add this line to you respond_to block
    end
  end

  def orders
    @order = Order.where(:store_id => current_trader.store.id, :order_validation => false)
    @orders = @order.group_by(&:user_id)
    @amount = SumOrders.new(@orders).call

    respond_to do |format|
      format.js {render layout: false} # Add this line to you respond_to block
    end
  end
end
