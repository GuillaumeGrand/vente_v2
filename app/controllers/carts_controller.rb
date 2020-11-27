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
    cart_id = params["cart_id"]
    product_quantity = params["quantity"]
    cart = Cart.find(cart_id)
    cart.quantity = product_quantity
    cart.save

    # respond_to do |format|
    #   format.js {render inline: "location.reload();" }
    # end

    redirect_to "http://localhost:3000/carts"
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
