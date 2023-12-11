# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!

  def like
    @tweet = Tweet.find(params[:id])
    liked = @tweet.likes.exists?(user: current_user)

    if liked
      Like.find_by(user: current_user, tweet: @tweet).destroy!
    else
      @tweet.likes.create!(user: current_user)
    end
  end
end
