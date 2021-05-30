module Stripe
  class CheckoutSessionCreate
    def initialize(cart, base_url, store_id)
      @cart = cart
      @base_url = base_url
      @store_id = store_id
    end

    def call
      Stripe::Checkout::Session.create({
                                                   payment_method_types: ['card'],
                                                   line_items: [{
                                                     name: @cart[0].store.name,
                                                     amount: Total.new(@cart).call,
                                                     currency: 'eur',
                                                     quantity: 1
                                                   }],
                                                   payment_intent_data: {
                                                     application_fee_amount: 0,
                                                     transfer_data: {
                                                       destination: @cart[0].store.trader.stripe_account
                                                     }
                                                   },
                                                   success_url: @base_url + "/checkouts/success/#{@store_id}",
                                                   cancel_url: @base_url
                                                 })

    end
  end
end
