class AddStripeAccountToTrader < ActiveRecord::Migration[6.0]
  def change
    add_column :traders, :stripe_account, :string
  end
end
