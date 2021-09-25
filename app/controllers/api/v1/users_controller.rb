class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(email: req[:email], password: req[:password], password_confirmation: req[:password_confirmation])

    if user.save
      json_response(UserSerializer.new(user))
    else
      json_response(ErrorMessage.bad_credentials_for_user, :bad_request)
    end
  end
end
