class Api::V1::RoadtripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if params[:api_key].present? && !user.nil?
      roadtrip = RoadtripFacade.create_roadtrip(params[:origin], params[:destination])
      json_response(RoadtripSerializer.new(roadtrip))
    else
      json_response(ErrorMessage.roadtrip_info_missing, :bad_request)
    end
  end

  private

  def roadtrip_params
    params.permit(:origin, :destination, :api_key)
  end

  def api_key_present_and_valid?
    params[:api_key].present?
  end
end
