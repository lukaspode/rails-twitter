# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: %i[follower followed] do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    name { Faker::Name.first_name }
    birth { Faker::Date.birthday(min_age: 18) }
    sequence :username do |n|
      Faker::Internet.username.to_s + n.to_s
    end
    bio { Faker::Lorem.paragraph_by_chars(number: Faker::Number.between(from: 1, to: 160)) }
    website { Faker::Internet.url }
  end
end
