class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location]
      location = GeocodeFacade.create_location(params[:location])
      forecast = ForecastFacade.create_weather(location.latitude, location.longitude)
      json_response(ForecastSerializer.new(forecast))
    else
      json_response(ErrorMessage.location_not_included_error, :bad_request)
    end
  end
end
