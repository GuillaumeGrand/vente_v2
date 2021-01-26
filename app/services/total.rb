# frozen_string_literal: true

class Total
  def initialize(cart)
    @cart = cart
  end

  def call
    amount = 0
    @cart.each do |product|
      amount += (product.quantity * product.product.price_cents)
    end
    amount
  end
end
