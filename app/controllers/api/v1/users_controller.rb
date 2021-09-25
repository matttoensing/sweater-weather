class Api::V1::UsersController < ApplicationController
  def create

    user = request.body.read
    require "pry"; binding.pry
  end
end
