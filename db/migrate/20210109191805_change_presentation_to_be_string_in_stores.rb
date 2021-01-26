# frozen_string_literal: true

class ChangePresentationToBeStringInStores < ActiveRecord::Migration[6.0]
  def change
    change_column :stores, :presentation, :string
  end
end
