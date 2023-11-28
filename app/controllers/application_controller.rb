# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def current_user?(user)
    user == current_user
  end

  helper_method :current_user?
end
