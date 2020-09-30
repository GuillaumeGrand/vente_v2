class CheckoutController < ApplicationController
  def create

    carts = FetchCart.new(params[:store_id],params[:user]).call

    amount = 0
    carts.each do |cart|
      amount += (cart.quantity * cart.product.price_cents )
    end

      # session = Stripe::Checkout::Session.create({
      #   payment_method_types: ['card'],
      #   line_items: [{
      #     name: carts[0].store.name,
      #     amount: amount / 100,
      #     currency: 'eur',
      #     quantity: 1,
      #   }],
      #   payment_intent_data: {
      #     application_fee_amount: 0,
      #     transfer_data: {
      #       destination: '{{CONNECTED_STRIPE_ACCOUNT_ID}}',
      #     },
      #   },
      #   success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      #   cancel_url: checkout_cancel_url,
      # })
p "1" * 150
p carts
      @intent = Stripe::PaymentIntent.create({
        payment_method_types: ['card'],
        amount: amount / 100,
        currency: 'eur',
        application_fee_amount: 1,
        transfer_data: {
        destination: carts[0].store.trader.stripe_id,
        },
      })

    respond_to do |format|
      format.js # renders create.js.erb
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel

  end
end
