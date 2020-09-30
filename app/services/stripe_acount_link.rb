class StripeAcountLink
  def initialize(acount, user)
    @acount = acount
    @user = user
  end

  def call
    account_links = Stripe::AccountLink.create({
      account: @acount["id"],
      refresh_url: 'http://localhost:3000/',
      return_url: 'http://localhost:3000/',
      type: 'account_onboarding',
    })
    @user.update(stripe_id: @acount["id"])
  end
end
