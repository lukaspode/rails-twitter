# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :set_user

  def index; end

  def show
    @tweet = @user.tweets.find(params[:id])
    return unless current_user

    @liked = current_user.likes.find_by(tweet_id: @tweet.id)
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

  def set_user
    @user = User.find(params[:user_id])
  end

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end