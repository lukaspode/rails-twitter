# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :likes, dependent: :destroy
  has_many :user_likes, through: :likes, source: :user

  validates :content, length: { minimum: 1, maximum: 280 }, presence: true

  has_many_attached :images

  def liked?
    respond_to?(:liked) ? liked == 1 : false
  end

  def self.ransackable_attributes(_auth_object = nil)
    ['content']
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end
end
