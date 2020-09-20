class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :presentation
      t.integer :price_cents, default: 0, null: false
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
