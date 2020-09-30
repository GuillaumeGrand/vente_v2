class Trader < ApplicationRecord
  has_one :store
  validates :email, :presence => true, :uniqueness => true
  # after_create :stripe_acount
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # private
  # def stripe_acount
  #   acount = StripeAcountTrader.new.call
  #   StripeAcountLink.new(acount, self).call
  # end
end
