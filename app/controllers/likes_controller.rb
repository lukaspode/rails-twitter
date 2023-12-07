# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, :set_user

  def create
    @tweet.likes.create!(user: current_user)
    redirect_to @user
  end

  def destroy
    @like = current_user.liked_tweets.find(params[:tweet_id])
    @like.destroy
    redirect_to @user
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
