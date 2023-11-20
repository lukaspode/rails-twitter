# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    name { Faker::Name.first_name }
    birth { Faker::Date.birthday(min_age: 18) }
    username { Faker::Internet.username }
  end
end
