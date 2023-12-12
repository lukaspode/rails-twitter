# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  validate :self_like

  private

  def self_like
    return unless user_id.present? && user_id == tweet.user_id

    errors.add('you cannot like your own tweet')
  end
end
