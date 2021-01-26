# frozen_string_literal: true

module Stripe
  class AccountLinks
    def initialize(account, trader_id, base_url)
      @account = account
      @trader_id = trader_id
      @base_url = base_url
    end

    def call
      account_links = Stripe::AccountLink.create({
                                                   account: @account['id'],
                                                   refresh_url: @base_url,
                                                   return_url: @base_url,
                                                   type: 'account_onboarding'
                                                 })

      trader = Trader.find(@trader_id)
      trader.update(stripe_account: @account['id'])
    end
  end
end
