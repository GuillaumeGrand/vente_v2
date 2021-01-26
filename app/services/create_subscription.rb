# frozen_string_literal: true

class CreateSubscription
  def initialize(trader)
    @trader_id = trader.id
  end

  def call
    sub = Subscription.create(trader_id: @trader_id)
    sub.save
    p '1' * 150
  end
end
