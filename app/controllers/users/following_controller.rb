# frozen_string_literal: true

module Users
  class FollowingController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def index
      @following = @user.followed_users
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
