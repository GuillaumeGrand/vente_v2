# frozen_string_literal: true

FactoryBot.define do
  before(:create, :trader) do
    factory :store do
      association :trader
      id { Faker::IDNumber.valid_south_african_id_number }
      name { 'Magasin de chausure' }
      presentation { '123456789 123456789 123456789 123456789 123456789 ' }
      created_at { '2020-11-19 08:54:55' }
      updated_at { '2020-12-21 22:29:59' }
      trader_id { Faker::IDNumber.valid_south_african_id_number }
    end
  end
end
