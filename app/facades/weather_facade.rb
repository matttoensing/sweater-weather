class WeatherFacade
  def self.create_weather(city)
    json = WeatherService.get_weather_info(city)
    Weather.new(json)
  end
end
