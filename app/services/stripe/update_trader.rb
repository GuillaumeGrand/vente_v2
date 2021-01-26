# frozen_string_literal: true

module Stripe
  class UpdateTrader
    def initialize(account_id, token)
      @account_id = account_id
      @token = token
    end

    def call
      Stripe::Account.update(
        @account_id,
        business_profile: {
          product_description: 'product_description'
        },
        capabilities: {
          transfers: { requested: true }
        },
        # individual: {
        #   verification: {
        #     document: {
        #       front: @file,
        #     },
        #   },
        # },
        account_token: @token
      )
    end
  end
end
