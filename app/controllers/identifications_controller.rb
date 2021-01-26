# frozen_string_literal: true

class IdentificationsController < ApplicationController
  protect_from_forgery except: :trader_update

  def info_stripe
    @user = User.find(current_user.id)
  end

  def user_info
    # user = User.find(current_user.id)
    base_url = Rails.application.config_for(:domain)[:base_url]

    acount = Stripe::CreateUser.new.call
    Stripe::AccountLinksUser.new(acount, base_url).call

    redirect_to root_path
  end

  def trader_info
    @trader = Trader.find(current_trader.id)
  end

  def trader_info_create
    base_url = Rails.application.config_for(:domain)[:base_url]
    trader = Trader.find(current_trader.id)
    account = Stripe::CreateTrader.new(params['token-account']).call
    Stripe::AccountLinks.new(account, trader.id, base_url).call
    trader.update(stripe_account: account['id'])
    # person = Stripe::CreatePerson.new(account["id"], params['token-person']).call
    # trader.update(person_id: person["id"])

    redirect_to root_path
  end

  def trader_edit
    @trader = Trader.find(current_trader.id)
  end

  def trader_update
    trader = Trader.find(current_trader.id)
    Stripe::CreateFile.new(params['front'], trader.stripe_account)
    Stripe::UpdateTrader.new(trader.stripe_account, params['token-account']).call
    redirect_to root_path
  end

  def trader_person
    trader = Trader.find(current_trader.id)
    account = trader.stripe_account
    token = params['token-person']

    person = Stripe::Account.create_person(
      account, # id of the account created earlier
      {
        person_token: token
      }
    )
  end

  def user_params
    params.require(:user).permit(:email, :country, :legal_name, :adress_1, :adress_2, :city, :area, :zip_code,
                                 :phone_number)
  end

  def trader_params
    params.require(:trader).permit(:product_description, :first_name, :last_name, :day, :month, :year, :line1, :line2,
                                   :postal_code, :city, :country, :external_account)
  end
end
