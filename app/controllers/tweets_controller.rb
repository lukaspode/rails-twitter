# frozen_string_literal: true

class TweetsController < ApplicationController
  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
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
