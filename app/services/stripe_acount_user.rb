class StripeAcountUser
  def call
     Stripe::Account.create({
      type: 'express',
      requested_capabilities: ['transfers'],
    })
  end
end
