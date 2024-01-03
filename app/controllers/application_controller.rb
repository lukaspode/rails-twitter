# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :mobile?

  def after_sign_in_path_for(_resource)
    feed_index_path
  end
end
