class Api::V1::UsersController < ApplicationController
  after_action :set_code_on_create, only: [:create]

  def create
    user = User.create(user_params)

    if user.save
      json_response(UserSerializer.new(user))
    else
      json_response(ErrorMessage.bad_credentials_for_user, :bad_request)
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def set_code_on_create
    response.status = 201 if response.status == 200
  end
end
