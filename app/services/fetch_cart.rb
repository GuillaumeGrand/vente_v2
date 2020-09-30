class FetchCart
  def initialize(store_id, user_id)
      @store_id = store_id.to_i
      @user_id = user_id.to_i
  end

  def call
    @cart_product = Cart.all.where(:user_id => @user_id, :store_id => @store_id)
    @cart_product.each do |cart|
      order  = Order.create!(quantity: cart.quantity, user_id: @user_id, store_id: @store_id, product_id: cart.product.id)
    end
  end

  def amount
    amount = 0
    @cart_product.each do |cart|
      amount += (cart.quantity * cart.product.price_cents )
    end
    return amount
  end

end
