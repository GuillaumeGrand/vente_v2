module Stripe
  class AccountLinks
    def initialize(account, trader_id)
      @account = account
      @trader_id = trader_id
    end

    def call
      account_links = Stripe::AccountLink.create({
        account: @account["id"],
        refresh_url: '/',
        return_url: '/',
        type: 'account_onboarding',
      })

      trader = Trader.find(@trader_id)
      trader.update(stripe_account: @account["id"])
    end
  end
end
