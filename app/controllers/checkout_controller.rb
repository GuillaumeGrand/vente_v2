class CheckoutController < ApplicationController
  def create

    carts = FetchCart.new(params[:store_id],params[:user]).call

    carts.each do |cart|

      order  = Order.create!(quantity: cart.quantity, user_id: params[:user], store_id: params[:store_id], product_id: cart.product.id)

      @session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: cart.product.name,
          amount: cart.quantity * cart.product.price_cents,
          currency: 'eur',
          quantity: cart.quantity
        }],
        success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
        cancel_url: checkout_cancel_url
      )
    end

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
