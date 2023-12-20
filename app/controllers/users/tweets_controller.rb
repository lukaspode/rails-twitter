# frozen_string_literal: true

module Users
  class TweetsController < ApplicationController
    before_action :set_user

    def index; end

    def show
      @tweet = @user.tweets.find(params[:id])
      return unless current_user

      @liked = current_user.likes.find_by(tweet_id: @tweet.id)
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
