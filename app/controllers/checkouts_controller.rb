class CheckoutsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create_checkout
    user_id = current_user.id
    cart = FetchCart.new(params[:store_id],user_id).call

      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          name: cart[0].store.name,
          amount: Total.new(cart).call,
          currency: 'eur',
          quantity: 1,
        }],
        payment_intent_data: {
          application_fee_amount: 0,
          transfer_data: {
            destination: cart[0].store.trader.stripe_account,
          },
        },
        success_url: "/",
        cancel_url: "/stores/1",
      })
      CreateOrder.new(cart,user_id).call
      render json: session

  end


end
