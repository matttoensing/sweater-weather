class Weather
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather,
              :id

  def initialize(info)
    @id = nil
    @current_weather = create_current_weather(info)
    @daily_weather = create_daily_weather(info[:forecast][:forecastday])
    @hourly_weather = create_hourly_weather(info[:forecast][:forecastday][0][:hour])
  end

  def create_current_weather(data)
    CurrentWeather.new(data)
  end

  def create_daily_weather(data)
    data.map do |details|
      DailyWeather.new(details)
    end
  end

  def create_hourly_weather(data)
    data.map do |details|
      HourlyWeather.new(details)
    end
  end
end
