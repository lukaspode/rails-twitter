# frozen_string_literal: true

module Users
  class FollowersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def index
      @followers = if current_user
                     @user.follower_users
                          .select('users.*',
                                  "COUNT(CASE WHEN c_u.follower_id = #{current_user.id} THEN 1 ELSE NULL END) AS following")
                          .joins("LEFT OUTER JOIN (SELECT u.*, f.followed_id, f.follower_id
                                                 FROM follows AS f INNER JOIN users AS u ON f.followed_id = u.id
                                                 WHERE f.follower_id = #{current_user.id}
                              ) AS c_u ON users.id = c_u.followed_id")
                          .group('users.id')
                   else
                     @user.followed_users
                   end
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
