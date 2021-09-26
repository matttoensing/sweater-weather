class Api::V1::RoadtripController < ApplicationController
  def create
    user = User.find_by!(api_key: params[:api_key])
    if api_key_present? && origin_and_destination_params_present?
      roadtrip = RoadtripFacade.create_roadtrip(params[:origin], params[:destination])
      return json_response(ErrorMessage.roadtrip_route_not_aavailable, :bad_request) if roadtrip.nil?

      json_response(RoadtripSerializer.new(roadtrip))
    else
      json_response(ErrorMessage.roadtrip_info_missing, :bad_request)
    end
  end

  private

  def api_key_present?
    params[:api_key].present?
  end

  def origin_and_destination_params_present?
    params[:origin].present? && params[:destination].present?
  end
end
