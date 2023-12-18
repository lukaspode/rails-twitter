# frozen_string_literal: true

module Users
  class FollowersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def index
      @followers = if current_user
                     select_stmt = <<-SQL.squish
                      users.*,
                      (
                        CASE
                        WHEN current_user_follows.id IS NOT NULL THEN TRUE
                        ELSE FALSE
                        END
                      ) AS following
                     SQL

                     join_stmt = <<-SQL.squish
                      LEFT JOIN follows AS current_user_follows
                      ON users.id = current_user_follows.followed_id
                      AND current_user_follows.follower_id = #{current_user.id}
                     SQL

                     @following = @user.follower_users
                                       .select(select_stmt)
                                       .joins(join_stmt)
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
