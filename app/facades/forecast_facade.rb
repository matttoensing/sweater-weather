class ForecastFacade
  def self.current_weather(lat, lon)
    json = WeatherService.get_weather_info(lat, lon)
    {
      datetime: Time.at(json[:current][:dt]).to_s,
      conditions: json[:current][:weather][0][:description],
      temperature: json[:current][:temp].round(1),
      humidity: json[:current][:humidity],
      feels_like: json[:current][:feels_like].round(1),
      uvi: json[:current][:uvi],
      visibility: json[:current][:visibility],
      sunrise: Time.at(json[:current][:sunrise]).to_s,
      sunset: Time.at(json[:current][:sunset]).to_s
    }
  end

  def self.hourly_weather(lat, lon)
    json = WeatherService.get_weather_info(lat, lon)[:hourly]
    json[1..8].map do |data|
    {
      time: Time.at(data[:dt]).strftime('%T').to_s,
      conditions: data[:weather][0][:description],
      temperature: data[:temp],
      icon: "http://openweathermap.org/img/w/#{data[:weather][0][:icon]}.png",
    }
    end
  end

  def self.daily_weather(lat, lon)
    json = WeatherService.get_weather_info(lat, lon)[:daily]
    json[1..5].map do |data|
    {
      date: Time.at(data[:dt]).strftime('%F').to_s,
      conditions: data[:weather][0][:description],
      max_temp: data[:temp][:max].round(1),
      min_temp: data[:temp][:min].round(1),
      sunrise: Time.at(data[:sunrise]).to_s,
      sunset: Time.at(data[:sunset]).to_s,
      icon: "http://openweathermap.org/img/w/#{data[:weather][0][:icon]}.png"
    }
    end
  end

  def self.weather_data(lat, lon)
    {
      current_weather: current_weather(lat, lon),
      daily_weather: daily_weather(lat, lon),
      hourly_weather: hourly_weather(lat, lon)
    }
  end

  def self.create_weather(lat, lon)
    Forecast.new(weather_data(lat, lon))
  end

#
# def self.create_weather(lat, lon)
#   json = WeatherService.get_weather_info(lat, lon)
#   Forecast.new(json)
# end
end
