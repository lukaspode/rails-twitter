# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    layout 'blank'

    private

    def sign_up_params
      params.require(resource_name)
            .permit(:name, :email, :password, :birth, :username)
    end
  end
end
