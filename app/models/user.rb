class User < ApplicationRecord

  has_many :orders
  # after_create :stripe_acount
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  private

  def stripe_acount
    acount = StripeAcountUser.new.call
    StripeAcountLink.new(acount, self).call
  end
end

