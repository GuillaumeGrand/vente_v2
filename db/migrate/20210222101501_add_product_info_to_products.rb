class AddProductInfoToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :product_characteristic, :text, presence: :true
  end
end
