class AddStripeIdtoTrader < ActiveRecord::Migration[6.0]
  def change
    add_column :trader, :stripe_id, :string
  end
end
