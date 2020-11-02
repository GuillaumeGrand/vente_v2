class CheckoutsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create_checkout
    user_id = current_user.id
    carts = FetchCart.new(params[:store_id],user_id).call

    amount = 0
    carts.each do |cart|
      amount += (cart.quantity * cart.product.price_cents )
    end
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          name: carts[0].store.name,
          amount: 999,
          currency: 'eur',
          quantity: 1,
        }],
        payment_intent_data: {
          application_fee_amount: 0,
          transfer_data: {
            destination: carts[0].store.trader.stripe_account,
          },
        },
        success_url: "http://localhost:3000",
        cancel_url: "http://localhost:3000/stores/1",
      })
      render json: session

  end
end
