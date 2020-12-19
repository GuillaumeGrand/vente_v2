class StoresController < ApplicationController
  def index
    if params["search"].present?
      @stores = Store.search(params["search"]["query"])
    else
      @stores = Store.search('*')
    end
  end

  def show
    @store = Store.find(params[:id])
    @cart = Cart.new
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
    @store = Store.find(params[:id])
    store_data = store_params

    if store_params["photos"].nil? == false
        Cloudinary::Uploader.destroy(@store.photos.key)
    end
    UpdateStoreService.new(params[:id], store_data).call
    redirect_to store_path(params[:id])
  end

  private

  def store_params
    params.require(:store).permit(:presentation, :name, :photos)
  end

end
