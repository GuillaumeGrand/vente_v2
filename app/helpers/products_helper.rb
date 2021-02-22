# frozen_string_literal: true

module ProductsHelper

  def check_stock(product)
    product.stock > 0 ? "En stock" : " stock vide"
  end
end
