# frozen_string_literal: true

class CheckoutsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create_checkout
    user_id = current_user.id
    cart = FetchCart.new(params[:store_id], user_id).call
    base_url = Rails.application.config_for(:domain)[:base_url]

    session = Stripe::Checkout::Session.create({
                                                 payment_method_types: ['card'],
                                                 line_items: [{
                                                   name: cart[0].store.name,
                                                   amount: Total.new(cart).call,
                                                   currency: 'eur',
                                                   quantity: 1
                                                 }],
                                                 payment_intent_data: {
                                                   application_fee_amount: 0,
                                                   transfer_data: {
                                                     destination: cart[0].store.trader.stripe_account
                                                   }
                                                 },
                                                 success_url: base_url + "/checkouts/success/#{params[:store_id]}",
                                                 cancel_url: base_url
                                               })

    render json: session
  end

  def success
    store_id = params[:store_id]
    user_id = current_user.id
    cart = FetchCart.new(store_id, user_id).call
    @orders = CreateOrder.new(cart, user_id).call
    CountOrder.new(store_id, cart).call
  end
end
