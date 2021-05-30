# frozen_string_literal: true

class CheckoutsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create_checkout
    user_id = current_user.id
    store_id = params[:store_id]
    cart = FetchCart.new(store_id, user_id).call
    base_url = Rails.application.config_for(:domain)[:base_url]

    session = Stripe::CheckoutSessionCreate.new(cart, base_url, store_id).call

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
