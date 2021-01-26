# frozen_string_literal: true

FactoryBot.define do
  before(:create, :store) do
    factory :product do
      association :store
      id { 1 }
      name { 'Basket de sport' }
      presentation { "N'hésitez plus à courir en hiver grâce à la Nike L..." }
      price_cents { 12_000 }
      store_id { 1 }
      created_at { '2020-11-19 09:02:33' }
      updated_at { '2020-12-22 11:17:13' }
      stock { 15 }
      reference { '123456' }
    end
  end
end
