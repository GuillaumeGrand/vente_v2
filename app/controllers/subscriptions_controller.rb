# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :authenticate_trader!, only: %i[index success checkout_sub checkout_session customer_portal]
  skip_before_action :verify_authenticity_token, only: %i[checkout_sub webhook]
  protect_from_forgery except: :webhook

  def index
    @plans = Stripe::Plan.list.data
    Stripe::CreateCustomer.new(current_trader.id).call
  end

  def success
    trader = Trader.find(current_trader.id)
    session_id = params[:session_id]
    session = Stripe::Checkout::Session.retrieve(session_id)
    trader.update(stripe_subscription_id: session['subscription'])
  end

  def checkout_sub
    base_url = Rails.application.config_for(:domain)[:base_url]
    data = JSON.parse(request.body.read)

    # See https://stripe.com/docs/api/checkout/sessions/create
    # for additional parameters to pass.
    # {CHECKOUT_SESSION_ID} is a string literal; do not change it!
    # the actual Session ID is returned in the query parameter when your customer
    # is redirected to the success page.
    begin
      session = Stripe::Checkout::Session.create(
        success_url: "#{base_url}/success?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: base_url,
        payment_method_types: ['card'],
        mode: 'subscription',
        line_items: [{
          quantity: 1,
          price: data['priceId']
        }]
      )
      render json: session
    rescue StandardError => e
      halt 400,
           { 'Content-Type' => 'application/json' },
           { 'error': { message: e.error.message } }.to_json
    end

    {
      sessionId: session.id
    }.to_json
  end

  def checkout_session
    session_id = params[:sessionId]

    session = Stripe::Checkout::Session.retrieve(session_id)
    session.to_json
    render json: session
  end

  def customer_portal
    data = JSON.parse(request.body.read)

    # For demonstration purposes, we're using the Checkout session to retrieve the customer ID.
    # Typically this is stored alongside the authenticated user in your database.
    checkout_session_id = data['sessionId']
    checkout_session = Stripe::Checkout::Session.retrieve(checkout_session_id)

    # This is the URL to which users will be redirected after they are done
    # managing their billing.
    return_url = ENV['DOMAIN']

    session = Stripe::BillingPortal::Session.create({
                                                      customer: checkout_session['customer'],
                                                      return_url: return_url
                                                    })
    {
      url: session.url
    }.to_json
  end

  def webhook
    webhook_secret = ENV['STRIPE_WEBHOOK_SECRET']
    payload = request.body.read
    if !webhook_secret.empty?
      # Retrieve the event by verifying the signature using the raw body and secret if webhook signing is configured.
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = nil

      begin
        event = Stripe::Webhook.construct_event(
          payload, sig_header, webhook_secret
        )
      rescue JSON::ParserError => e
        # Invalid payload
        status 400
        return
      rescue Stripe::SignatureVerificationError => e
        # Invalid signature
        puts '⚠️  Webhook signature verification failed.'
        status 400
        return
      end
    else
      data = JSON.parse(payload, symbolize_names: true)
      event = Stripe::Event.construct_from(data)
    end
    # Get the type of webhook event sent
    event_type = event['type']
    data = event['data']
    data_object = data['object']

    case event.type
    when 'checkout.session.completed'
    when 'customer.subscription.completed'

    when 'invoice.paid'

    when 'invoice.payment_failed'
      # The payment failed or the customer does not have a valid payment method.
      # The subscription becomes past_due. Notify your customer and send them to the
      # customer portal to update their payment information.
    when 'customer.created'
    else
      puts "Unhandled event type: #{event.type}"
    end

    # status 200
    head :ok
  end

  def delete_sub
    trader = Trader.find(current_trader.id)
    Stripe::Subscription.update(trader.stripe_subscription_id, { cancel_at_period_end: true })
    trader.update(stripe_subscription_id: nil)
    redirect_to root_path
  end
end
