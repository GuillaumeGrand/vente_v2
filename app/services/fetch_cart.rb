class FetchCart
  def initialize(store_id, user_id)
      @store_id = store_id.to_i
      @user_id = user_id.to_i
  end

  def call
    @cart_product = Cart.all.where(:user_id => @user_id, :store_id => @store_id)
  end
end
