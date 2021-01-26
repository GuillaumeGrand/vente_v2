# frozen_string_literal: true

module Stripe
  class CreateUser
    # def initialize(token)
    #   @token = token
    # end

    def call
      Stripe::Account.create({
                               type: 'express'
                               # account_token: @token,
                               # capabilities: {
                               #   transfers: {requested: true},
                               #   card_payments: {requested: true},
                               # },
                             })
    end
  end
end
