# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validate :self_follow

  private

  def self_follow
    return unless follower_id.present? && follower_id == followed_id

    errors.add('you cannot follow yourself')
  end
end
