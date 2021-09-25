class ForecastFacade
  def self.create_weather(lat, lon)
    json = WeatherService.get_weather_info(lat, lon)
    Forecast.new(json)
  end
end
