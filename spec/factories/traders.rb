# frozen_string_literal: true

FactoryBot.define do
  factory :trader do
    id { Faker::IDNumber.valid_south_african_id_number }
    email { Faker::Internet.email }
    stripe_account { 'acct_1Hp8ts2R2fENvmWZ' }
    stripe_subscription_id { nil }
    created_at { '2020-11-19 08:52:55' }
    updated_at { '2020-11-19 08:53:58' }
    password { 123_456 }
  end
end
