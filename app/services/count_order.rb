# frozen_string_literal: true

class CountOrder
  def initialize(store_id, cart)
    @store_id = store_id
    @cart = cart
  end

  def call
    store = Store.find(@store_id)
    cart = @cart.to_a.count
    store.free_count += cart
    store.save
    # early_month = Time.zone.now.beginning_of_month
    trader_sub = store.trader.stripe_subscription_id
    count = store.free_count

    if trader_sub.nil? && count > 5 && store.display == true
      store.display = false
      store.save
    end
  end
end
