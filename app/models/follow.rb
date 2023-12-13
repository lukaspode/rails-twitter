# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, inverse_of: 'followed', class_name: 'User', counter_cache: 'following_count'
  belongs_to :followed, inverse_of: 'followers', class_name: 'User', counter_cache: 'followers_count'

  validate :self_follow

  private

  def self_follow
    return unless follower_id.present? && follower_id == followed_id

    errors.add('you cannot follow yourself')
  end
end
