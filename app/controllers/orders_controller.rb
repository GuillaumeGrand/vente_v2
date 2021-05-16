# frozen_string_literal: true

class OrdersController < ApplicationController
  def dashboard
    current_trader.store ? @store = Store.find(current_trader.store.id) : ''

    if !current_trader.store.nil?
      @order = Order.find_order_validation_false
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
      format.js { render inline: 'location.reload();' }
    end
  end

  def user_show
    orders = Order.find_current_user_orders
    @stores_orders = orders.group_by(&:store_id)
  end

  def history
    @order = Order.find_order_validation_true
    @orders = @order.group_by(&:user_id)

    respond_to do |format|
      format.js { render layout: false } # Add this line to you respond_to block
    end
  end

  def orders
    @order = Order.find_order_validation_false
    @orders = @order.group_by(&:user_id)
    @amount = SumOrders.new(@orders).call

    respond_to do |format|
      format.js { render layout: false } # Add this line to you respond_to block
    end
  end
end
