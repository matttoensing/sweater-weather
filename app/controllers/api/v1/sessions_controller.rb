class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: req[:email])
    if !user.nil? && user.authenticate(req[:password])
      json_response(UserSerializer.new(user))
    else
     json_response(ErrorMessage.bad_credentials_for_user, :bad_request)
    end
  end
end
