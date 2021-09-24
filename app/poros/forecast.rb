class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather,
              :id

  def initialize(data)
    @id = nil
    @current_weather = CurrentWeather.new(data)
    @daily_weather = create_daily_weather(data[:forecast][:forecastday])
    @hourly_weather = create_hourly_weather(data[:forecast][:forecastday][0][:hour])
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
