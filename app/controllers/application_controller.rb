# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user?

  def current_user?(user)
    user == current_user
  end
end
