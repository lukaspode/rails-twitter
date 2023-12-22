# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :user
  before_action :authenticate_user!, only: :follow
  include Pagy::Backend

  helper_method :current_user?

  def show
    if current_user
      @tweets = @user.tweets
                     .select('tweets.*',
                             "COUNT(CASE WHEN likes.user_id = #{current_user.id} THEN 1 ELSE NULL END) AS liked")
                     .left_joins(:likes)
                     .group('tweets.id')
                     .order(created_at: :desc)
      @followed = current_user.followed.exists?(followed: @user)
    else
      @tweets = @user.tweets
    end
  end

  def follow
    followed = current_user.followed.exists?(followed: @user)

    if followed
      Follow.find_by(followed_id: @user.id, follower_id: current_user.id).destroy!
    else
      @follow = current_user.followed.create(followed: @user)
      @follow.save
    end

    redirect_to @user
  end

  private

  def current_user?
    @user == current_user
  end

  def user
    @user ||= User.find(params[:id])
  end
end
