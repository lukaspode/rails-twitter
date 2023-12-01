# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    content { 'MyText' }
    user { nil }
  end
end
