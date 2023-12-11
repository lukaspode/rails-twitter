# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :user

  helper_method :current_user?

  def show
    @tweets = @user.tweets
                   .select('tweets.*',
                           "COUNT(CASE WHEN likes.user_id = #{current_user.id} THEN 1 ELSE NULL END) AS liked")
                   .left_joins(:likes)
                   .group('tweets.id')
                   .order(created_at: :desc)

    render :show
  end

  private

  def current_user?
    @user == current_user
  end

  def user
    @user ||= User.find(params[:id])
  end
end
