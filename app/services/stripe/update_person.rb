module Stripe
  class UpdatePerson

    def initialize(account_id, person_id, person_token)
      @account_id = account_id
      @person_token = person_token
      @person_id = person_id
      # @trader_params = trader_params
    end

    def call
      Stripe::Account.update_person(
        @account_id, # id of the account created earlier
        @person_id,
        {
          person_token: @person_token,
        }
      )
    end
  end
end
