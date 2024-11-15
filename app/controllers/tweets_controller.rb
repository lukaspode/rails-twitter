# frozen_string_literal: true

class TweetsController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @tweet = @user.tweets.find(params[:id])
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to user_path(current_user), message: 'Tweet successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
