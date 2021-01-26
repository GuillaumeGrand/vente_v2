# frozen_string_literal: true

class StoresController < ApplicationController
  def index
    @stores = if params['search'].present?
                Store.search(params['search']['query'])
              else
                Store.search('*')
              end
  end

  def show
    @store = Store.find(params[:id])
    @cart = Cart.new
  end

  def trader_show
    @store = Store.find(current_trader.store.id)
    # @cart = Cart.new
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.create(store_params)
    @store.trader = Trader.find(current_trader.id)
    # CreateSubscription.new(current_trader).call
    if @store.save
      redirect_to store_path(@store)
    else
      render action: 'index'
    end
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])
    store_data = store_params

    Cloudinary::Uploader.destroy(@store.photos.key) if store_params['photos'].nil? == false
    UpdateStoreService.new(params[:id], store_data).call
    redirect_to store_path(params[:id])
  end

  private

  def store_params
    params.require(:store).permit(:presentation, :name, :photos)
  end
end
