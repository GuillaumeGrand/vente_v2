class StoresController < ApplicationController
  def index
    @store = Store.all
  end

  def show
    store = Store.find(params[:id])

    if current_trader.id == store.trader.id
      @store = store
    else
      redirect_to stores_path(store)
    end
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

  def edit
     @store = Store.find(params[:id])
  end

  def update
    store_data = store_params
    UpdateStoreService.new(params[:id], store_data).call
    redirect_to store_path(params[:id])
  end

  private

  def store_params
    params.require(:store).permit(:presentation, :name, :photos)
  end

end
