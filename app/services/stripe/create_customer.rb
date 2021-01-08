module Stripe
  class CreateCustomer

    def initialize(trader_id)
      @trader_id = trader_id
    end

    def call
       account = Stripe::Customer.create()
       trader = Trader.find(@trader_id)
       # trader.update(person_id: account["id"])
    end
  end
end
