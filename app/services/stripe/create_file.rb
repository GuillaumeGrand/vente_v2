# frozen_string_literal: true

module Stripe
  class CreateFile
    def initialize(file, account)
      @file = file
      @account = account
    end

    def call
      Stripe::File.create({
                            purpose: 'identity_document',
                            file: File.new(@file)
                          }, {
                            stripe_account: @account
                          })
    end
  end
end
