class OrdersController < ApplicationController
  def dashboard
    current_trader.store ? @store = Store.find(current_trader.store.id) : ""
  end

  def show
  end
end
