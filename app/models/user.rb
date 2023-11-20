# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :birth, presence: true
  validate :validate_age

  private

  def validate_age

    return unless birth.present? && (birth > 18.years.ago.to_date)

    errors.add(:birth, ': your age must be over 18')
  end
end
