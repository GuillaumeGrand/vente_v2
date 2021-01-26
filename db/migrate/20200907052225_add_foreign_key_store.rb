# frozen_string_literal: true

class AddForeignKeyStore < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :trader_id, :integer
    add_foreign_key :stores, :traders
  end
end
