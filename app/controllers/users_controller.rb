# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :user

  helper_method :current_user?

  def show; end

  private

  def current_user?
    @user == current_user
  end

  def user
    @user ||= User.find(params[:id])
  end
end
