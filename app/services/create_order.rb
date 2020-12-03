class CreateOrder
  def initialize(cart, user_id)
      @cart = cart
      @user_id = user_id.to_i
  end

  def call
    @cart.each do |cart|
      order  = Order.create!(quantity: cart.quantity, user_id: @user_id, store_id: cart.store_id, product_id: cart.product.id)
    end
  end
end
