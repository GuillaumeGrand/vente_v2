# frozen_string_literal: true

class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.text :presentation
      t.boolean :display, default: true
      t.integer :free_count, default: 0

      t.timestamps
    end
  end
end
