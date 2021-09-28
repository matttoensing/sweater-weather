class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by!(email: params[:email])
    if !user.nil? && user.authenticate(params[:password])
      json_response(UserSerializer.new(user))
    else
      json_response(ErrorMessage.bad_credentials_for_user, :bad_request)
    end
  end
end
