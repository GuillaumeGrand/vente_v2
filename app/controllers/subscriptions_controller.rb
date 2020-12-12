class SubscriptionsController < ApplicationController
  before_action :authenticate_trader!, :only => [:index, :success, :checkout_sub, :checkout_session, :customer_portal]
  skip_before_action :verify_authenticity_token, :only => [:checkout_sub, :webhook]
  protect_from_forgery except: :webhook

  def index
    @plans = Stripe::Plan.list.data
    Stripe::CreateCustomer.new(current_trader.id).call
    @@trader = Trader.find(current_trader.id)
  end

  def success

  end

  def checkout_sub
    data = JSON.parse(request.body.read)

    # See https://stripe.com/docs/api/checkout/sessions/create
    # for additional parameters to pass.
    # {CHECKOUT_SESSION_ID} is a string literal; do not change it!
    # the actual Session ID is returned in the query parameter when your customer
    # is redirected to the success page.
    begin
      session = Stripe::Checkout::Session.create(
        success_url: 'http://localhost:3000/success?session_id={CHECKOUT_SESSION_ID}',
        cancel_url: 'http://localhost:3000/',
        payment_method_types: ['card'],
        mode: 'subscription',
        line_items: [{
          quantity: 1,
          price: data['priceId'],
        }],
      )
      render json: session
    rescue => e
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
    subscription = event["data"]["object"]["subscription"]
    @@trader.update(stripe_subscription_id: subscription)

  when 'invoice.paid'
    # Continue to provision the subscription as payments continue to be made.
    # Store the status in your database and check when a user accesses your service.
    # This approach helps you avoid hitting rate limits.
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
    Stripe::Subscription.update(@@trader.stripe_subscription_id, {cancel_at_period_end: true})
    @@trader.update(stripe_subscription_id: nil)
    redirect_to root_path
  end

end
