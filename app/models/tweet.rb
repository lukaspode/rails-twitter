# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :likes, dependent: :destroy
  has_many :user_likes, through: :likes, source: :user

  validates :content, length: { minimum: 1, maximum: 280 }, presence: true
end
