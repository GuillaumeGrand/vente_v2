# frozen_string_literal: true

class ProductsController < ApplicationController
  def index; end

  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
  end

  def edit
    @store = Store.find(current_trader.store.id)
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if product_params['photos'].nil? == false
      @product.photos.each do |photo|
        Cloudinary::Uploader.destroy(photo.key)
      end
    end
    @product.update(product_params)
    redirect_to store_path(@product.store.id)
  end

  def new
    @store = Store.find(current_trader.store.id)
    @product = Product.new
  end

  def create
    product = Product.new(product_params)
    @store = Store.find(params[:store_id])
    product.store = @store
    product.save
    redirect_to store_path(@store)
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy

    # no need for app/views/restaurants/destroy.html.erb
    redirect_to store_path(product.store)
  end

  private

  def product_params
    params.require(:product).permit(:name, :presentation, :price, :stock, :product_characteristic, photos: [])
  end
end
