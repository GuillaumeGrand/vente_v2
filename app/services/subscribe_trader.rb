class SubscribeTrader
  def initialize(trader)
      @trader = trader
      @plan_id = price_1HjNWcCV96yeUuNKWhjJCHbi
  end

  def call
    if @trader.stripe_id.nil?
        redirect_to success_path, :flash => {:error => 'Firstly you need to enter your card'}
        return
      end
      #if there is no card

      customer = Stripe::Customer.new @trader.stripe_id
      #we define our customer

      subscriptions = Stripe::Subscription.list(customer: customer.id)

      subscriptions.each do |subscription|
        subscription.delete
      end
      #we delete all subscription that the customer has. We do this because we don't want that our customer to have multiple subscriptions


      subscription = Stripe::Subscription.create({
                                                     customer: customer,
                                                     items: [{plan: @plan_id}], })
   #we are creating a new subscription with the plan_id we took from our form

      subscription.save
      redirect_to root_path
  end
end
