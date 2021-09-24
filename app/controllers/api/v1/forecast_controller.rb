class Api::V1::ForecastController < ApplicationController
  def index
    location = GeocodeFacade.create_location(params[:location])
    forecast = ForecastFacade.create_weather(location.latitude, location.longitude)
    json_response(ForecastSerializer.new(forecast))
  end
end
