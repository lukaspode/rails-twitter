# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    content { Faker::Lorem.paragraph_by_chars(number: Faker::Number.between(from: 1, to: 280)) }
    user
  end
end
