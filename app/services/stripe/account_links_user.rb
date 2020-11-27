module Stripe
  class AccountLinksUser
    def initialize(account)
      @account = account
    end

    def call
      account_links = Stripe::AccountLink.create({
        account: @account["id"],
        refresh_url: 'http://localhost:3000/',
        return_url: 'http://localhost:3000/',
        type: 'account_onboarding',
      })
    end
  end
end
