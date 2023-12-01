class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :user

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
    params.require(:user).permit(:name, :bio, :website, :birth)
  end
end
