# frozen_string_literal: true

module Users
  class FollowersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def index
      @followers = if current_user
                     @user.follower_users
                          .select('users.*',
                                  "COUNT(CASE WHEN f.followed_id = #{current_user.id} THEN 1 ELSE NULL END) AS following")
                          .joins("LEFT JOIN follows AS f ON f.followed_id = #{current_user.id}")
                          .group('users.id')
                   else
                     @user.follower_users
                   end
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
