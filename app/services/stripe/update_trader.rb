module Stripe
  class UpdateTrader

    def initialize(account_id, account_token)
      @account_id = account_id
      @account_token = account_token
    end

    def call
      Stripe::Account.update(
        @account_id,
        business_profile: {
          product_description: "product_description",
        },
        capabilities: {
          transfers: {requested: true},
        },
        account_token: @account_token,
      )
    end
  end
end
