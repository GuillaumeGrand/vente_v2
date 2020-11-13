class IdentificationsController < ApplicationController

  def identification
  end

  def info_stripe
    @user = User.find(current_user.id)
  end

  def user_info
    user = User.find(current_user.id)

    acount = Stripe::CreateUser.new.call
    Stripe::AccountLinks.new(acount).call

    redirect_to root_path
  end

  def trader_info
    @trader = Trader.find(current_trader.id)
  end

  def trader_info_create
    trader = Trader.find(current_trader.id)
    account = Stripe::CreateTrader.new( params['token-account']).call
    Stripe::AccountLinks.new(account, trader.id).call
    trader.update(stripe_account: account["id"])
    # person = Stripe::CreatePerson.new(account["id"], params['token-person']).call
    # trader.update(person_id: person["id"])

    redirect_to root_path
  end

  def trader_edit
    @trader = Trader.find(current_trader.id)
  end

  def trader_update
    trader = Trader.find(current_trader.id)
    Stripe::UpdateTrader.new(trader.stripe_account,  params['token-account']).call
    # Stripe::UpdatePerson.new(trader.stripe_account, trader.person_id, params['token-person']).call
    redirect_to root_path
  end

  def trader_person
    trader = Trader.find(current_trader.id)
    account = trader.stripe_account
    token = params['token-person']

    person = Stripe::Account.create_person(
      account, # id of the account created earlier
      {
      person_token: token,
      }
    )
  end

  def user_params
    params.require(:user).permit(:email, :country, :legal_name, :adress_1, :adress_2, :city, :area, :zip_code, :phone_number)
  end

  def trader_params
    params.require(:trader).permit(:product_description, :first_name, :last_name, :day, :month, :year, :line1, :line2, :postal_code, :city, :country, :external_account)
  end
end
