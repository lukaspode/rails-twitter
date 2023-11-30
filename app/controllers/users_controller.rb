# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :require_signin, only: %i[edit update]
  before_action :user_equal_current_user?, only: %i[edit update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :bio, :website, :birth)
  end

  def require_signin
    return if current_user

    redirect_to new_user_session_path
  end

  def user_equal_current_user?
    return if current_user?(@user) && current_user

    redirect_to user_path(@user)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
