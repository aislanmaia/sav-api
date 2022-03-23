# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    address {
      {
        street: Faker::Address.street_name,
        number: Faker::Address.building_number,
        neighborhood: Faker::Address.community,
        city: Faker::Address.city,
        uf: Faker::Address.state_abbr
      }
    }
  end
end
