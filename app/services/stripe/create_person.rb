# frozen_string_literal: true

module Stripe
  class CreatePerson
    def initialize(account_id, person_token)
      @account_id = account_id
      @person_token = person_token
    end

    def call
      Stripe::Account.create_person(
        @account_id, # id of the account created earlier
        {
          person_token: @person_token
        }
      )
    end
  end
end
