class AddPersonIdToTrader < ActiveRecord::Migration[6.0]
  def change
    add_column :traders, :person_id, :string
  end
end
