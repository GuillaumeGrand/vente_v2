class SumOrders
  def initialize(orders)
    @orders = orders
  end

  def call
    @amount = []

    @orders.each do |order|
      amount = 0
      order[1].each do |products|
      amount += products.quantity * (products.product.price_cents / 100)
      end
      @amount.push(amount)
    end
    @amount
  end
end
