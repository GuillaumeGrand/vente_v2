class CartsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = current_user.id
    cart = Cart.new(cart_params)
    cart.user_id = user
    cart.save

    redirect_to carts_path
  end

  def update

  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy

    redirect_to carts_path
  end

  def index
    cart_product = Cart.where(:user_id => current_user.id)
    @cart_product = cart_product.group_by(&:store_id)
  end

  private

  def cart_params
    params.require(:cart).permit(:product_id, :store_id,:quantity )
  end
end
