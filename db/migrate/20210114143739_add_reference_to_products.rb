# frozen_string_literal: true

class AddReferenceToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :reference, :string
  end
end
