# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, :set_user

  def create
    like = @tweet.likes.new(user: current_user)
    if like.save
      redirect_to @user
    else
      render :@user, status: :unprocessable_entity
    end
  end

  def destroy
    like = current_user.likes.find(params[:id])
    like.destroy

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
