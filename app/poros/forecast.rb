class Forecast
  attr_reader :current_weather,
  :daily_weather,
  :hourly_weather,
  :id

  #   def initialize(data)
  #     @id = nil
  #     @current_weather = data[:current_weather]
  #     @daily_weather = data[:daily_weather]
  #     @hourly_weather = data[:hourly_weather]
  #   end
  # end


  def initialize(data)
    @id = nil
    @current_weather = CurrentWeather.new(data)
    @daily_weather = create_daily_weather(data[:daily])
    @hourly_weather = create_hourly_weather(data[:hourly])
  end

  def create_daily_weather(data)
    data[1..5].map do |details|
      DailyWeather.new(details)
    end
  end
  
  def create_hourly_weather(data)
    data[1..8].map do |details|
      HourlyWeather.new(details)
    end
  end
end
