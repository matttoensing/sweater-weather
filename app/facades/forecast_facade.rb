class ForecastFacade
  def self.create_weather(lat, lon, units = 'imperial')
    json = WeatherService.get_weather_info(lat, lon, units)
    Forecast.new(json)
  end
end
