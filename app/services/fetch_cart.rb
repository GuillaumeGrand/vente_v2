# frozen_string_literal: true

class FetchCart
  def initialize(store_id, user_id)
    @store_id = store_id.to_i
    @user_id = user_id.to_i
  end

  def call
    @cart_product = Cart.all.find_user_orders_in_store(@user_id, @store_id)
  end
end
