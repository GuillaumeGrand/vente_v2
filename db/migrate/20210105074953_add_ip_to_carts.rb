# frozen_string_literal: true

class AddIpToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :ip, :string
  end
end
