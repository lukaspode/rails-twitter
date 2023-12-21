# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :user

  def index
    # @tweets = Tweet.select('*').order(created_at: :desc)
    join_stmt = <<-SQL.squish
                      INNER JOIN users AS u
                      ON u.id = tweets.user_id AND tweets.user_id != #{current_user.id}
                      LEFT JOIN likes AS current_user_likes
                      ON current_user_likes.tweet_id = tweets.id AND #{current_user.id} = current_user_likes.user_id
                      WHERE
                        u.id IN(
                          SELECT
                            f.followed_id FROM follows AS f
                          WHERE
                            f.followed_id = u.id
                            AND f.follower_id = #{current_user.id})
                        OR tweets.id IN(
                          SELECT
                            l.tweet_id FROM likes AS l INNER JOIN follows AS fol ON l.user_id = fol.followed_id
                            WHERE fol.follower_id = #{current_user.id}
                          )
    SQL

    @tweets = Tweet.select('tweets.*',
                           "COUNT(CASE WHEN current_user_likes.user_id = #{current_user.id} THEN 1 ELSE NULL END) AS liked").joins(join_stmt)
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
