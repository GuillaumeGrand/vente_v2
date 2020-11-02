class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :country, :string
    add_column :users, :legal_name, :string
    add_column :users, :adress_1, :string
    add_column :users, :adress_2, :string
    add_column :users, :city, :string
    add_column :users, :area, :string
    add_column :users, :zip_code, :integer
    add_column :users, :phone_number, :integer
  end
end
