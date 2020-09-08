class StoresController < ApplicationController
  def index
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.create(store_params)
    @store.trader = Trader.find(current_trader.id)

    if @store.save
      redirect_to store_path(@store)
    else
      render action: "index"
    end
  end
end
