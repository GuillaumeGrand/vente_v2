# frozen_string_literal: true

module Stripe
  class CreateTrader
    def initialize(token)
      @token = token
    end

    def call
      account = Stripe::Account.create({
                                         country: 'FR',
                                         business_profile: {
                                           product_description: 'product_description'
                                         },
                                         capabilities: {
                                           transfers: { requested: true }
                                         },
                                         type: 'custom',
                                         account_token: @token
                                       })
    end
  end
end
