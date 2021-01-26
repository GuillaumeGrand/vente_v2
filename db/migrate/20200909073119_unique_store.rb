# frozen_string_literal: true

class UniqueStore < ActiveRecord::Migration[6.0]
  def change
    add_index :stores, :trader_id, unique: true
  end
end
