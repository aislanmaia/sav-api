# frozen_string_literal: true

FactoryBot.define do
  factory :user_admin, class: User do
    role { 1 }
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456789' }
    registry { Faker::Number.number(digits: 5) }
  end

  factory :user_attendant, class: User do
    role { 2 }
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456789' }
    registry { Faker::Number.number(digits: 5) }
  end

  factory :user_technician, class: User do
    role { 3 }
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456789' }
    registry { Faker::Number.number(digits: 5) }
  end
end