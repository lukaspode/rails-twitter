# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  has_many :followers, inverse_of: 'followed', class_name: 'Follow', dependent: :destroy
  has_many :follower_users, through: :followers, source: :follower

  has_many :followed, inverse_of: 'follower', class_name: 'Follow', dependent: :destroy
  has_many :followed_users, through: :followed, source: :followed

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, length: { minimum: 2 }, presence: true
  validates :birth, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 20 }
  validates :bio, length: { maximum: 160 }
  validates :website, format: { with: %r{http(s)?://([a-z0-9-]+\.)?[a-z0-9-]+(\.[a-z]{2,})+} }, allow_blank: true
  validate :validate_age

  def following?
    respond_to?(:following) ? following == 1 : false
  end

  private

  def validate_age
    return unless birth.present? && (birth > 18.years.ago.to_date)

    errors.add(:birth, 'your age must be over 18')
  end
end
