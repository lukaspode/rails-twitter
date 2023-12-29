# frozen_string_literal: true

class SearchController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def index
    @q = Tweet.ransack(content_cont: params[:q])
    @filtered_tweets = @q.result(distinct: true)
    @pagy, @filtered_tweets = pagy_countless(@filtered_tweets, items: 10)

    @f = User.ransack(name_or_username_cont: params[:q])
    @filtered_users = @f.result(distinct: true)

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

    @filtered_users = @filtered_users
                      .select(select_stmt)
                      .joins(join_stmt)
  end
end
