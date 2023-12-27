# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      respond_to do |format|
        format.html { redirect_to user_path(current_user), message: 'Tweet successfully created' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def like
    @tweet = Tweet.find(params[:id])
    liked = @tweet.likes.exists?(user: current_user)

    if liked
      Like.find_by(user: current_user, tweet: @tweet).destroy!
    else
      @like = @tweet.likes.new(user: current_user)
      @like.save
    end
    @tweet.reload
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, images: [])
  end
end
