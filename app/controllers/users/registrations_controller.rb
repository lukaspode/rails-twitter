# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    layout 'blank'

    def create
      super do |resource|

      end

    end

    private

      def sign_up_params
        params.require(resource_name).
          permit(:name, :email, :password,:birth)
      end
  end
end;
