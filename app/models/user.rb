# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, length: { minimum: 2 }, presence: true
  validates :birth, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 20 }
  validates :bio, length: { maximum: 160 }
  validates :website, format: { with: %r{http(s)?://([a-z0-9-]+\.)?[a-z0-9-]+(\.[a-z]{2,})+} }, allow_blank: true
  validate :validate_age

  private

  def validate_age
    return unless birth.present? && (birth > 18.years.ago.to_date)

    errors.add(:birth, 'your age must be over 18')
  end
end
