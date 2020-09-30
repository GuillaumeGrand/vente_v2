class AddStripeSubscriptionIdToTraders < ActiveRecord::Migration[6.0]
  def change
    add_column :traders, :stripe_subscription_id, :string
  end
end
