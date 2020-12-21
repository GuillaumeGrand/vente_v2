module Stripe
  class AccountLinksUser
    def initialize(account)
      @account = account
    end

    def call
      account_links = Stripe::AccountLink.create({
        account: @account["id"],
        refresh_url: '/',
        return_url: '/',
        type: 'account_onboarding',
      })
    end
  end
end
