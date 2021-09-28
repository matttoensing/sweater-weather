class Api::V1::RoadtripController < ApplicationController
  # before_action :authenticate, only: :create

  def create
    user = User.find_by(api_key: params[:api_key])
    if user.nil? || api_key_not_present?
      json_response(ErrorMessage.api_key_invalid, :unauthorized)
    elsif origin_and_destination_params_present?
      roadtrip = RoadtripFacade.create_roadtrip(params[:origin], params[:destination])
      return json_response(ErrorMessage.roadtrip_route_not_available, :bad_request) if roadtrip.nil?

      json_response(RoadtripSerializer.new(roadtrip))
    else
      json_response(ErrorMessage.roadtrip_info_missing, :bad_request)
    end
  end

  private

  def api_key_not_present?
    !params[:api_key].present?
  end

  def origin_and_destination_params_present?
    params[:origin].present? && params[:destination].present?
  end
end
