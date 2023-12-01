# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]
  before_action :set_user, only: %i[show edit update]
  before_action :user_equal_current_user?, only: %i[edit update]

  helper_method :current_user?

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

  def current_user?
    @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :bio, :website, :birth)
  end

  def user_equal_current_user?
    redirect_to user_path(@user) unless current_user?
  end

  def set_user
    @user = User.find(params[:id])
  end
end
