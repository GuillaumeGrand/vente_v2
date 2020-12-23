module Stripe
  class AccountLinksUser
    def initialize(account, base_url)
      @account = account
      @base_url = base_url
    end

    def call
      account_links = Stripe::AccountLink.create({
        account: @account["id"],
        refresh_url: @base_url,
        return_url: @base_url,
        type: 'account_onboarding',
      })
    end
  end
end
