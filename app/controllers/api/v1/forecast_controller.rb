class Api::V1::ForecastController < ApplicationController
  def index
    forecast = WeatherFacade.create_weather(params[:location])
    json_response(ForecastSerializer.new(forecast))
  end
end
