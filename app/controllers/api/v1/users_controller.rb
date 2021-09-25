class Api::V1::UsersController < ApplicationController
  def create
    req = user_attributes
    user = User.create(email: req[:email], password: req[:password], password_confirmation: req[:password_confirmation])
    json_response(UserSerializer.new(user))
  end

  private

  def user_attributes
    json = request.body.read
    req = json_request(json)
  end
end
