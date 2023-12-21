# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :user

  def index
    join_stmt = <<-SQL.squish
                      INNER JOIN follows AS current_user_follows
                      ON (current_user_follows.followed_id = tweets.user_id
                      AND current_user_follows.follower_id = #{current_user.id})

                      LEFT JOIN likes AS current_user_likes
                      ON current_user_likes.tweet_id = tweets.id
                      AND current_user_likes.user_id = #{current_user.id}
    SQL

    @tweets = Tweet.select('tweets.*',
                           "COUNT(CASE WHEN current_user_likes.user_id = #{current_user.id} THEN 1 ELSE NULL END) AS liked")
                   .joins(join_stmt)
                   .order('created_at DESC').group('tweets.id')
    @tweet = Tweet.new
  end

  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user
    @user ||= current_user
  end

  def user_params
    params.require(:user).permit(:name, :bio, :website, :birth, :profile_image)
  end
end
