class StripeAcountTrader
  def call
     Stripe::Account.create({
      type: 'express',
       capabilities: {card_payments: {requested: true},
                          transfers: {requested: true},
                      },
    })
  end
end
