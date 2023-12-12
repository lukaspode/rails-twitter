# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!

  def like
    @tweet = Tweet.find(params[:id])
    liked = @tweet.likes.exists?(user: current_user)

    if liked
      Like.find_by(user: current_user, tweet: @tweet).destroy!
    else
      @like = @tweet.likes.new(user: current_user)
      @like.save
    end
  end
end
