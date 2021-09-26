class DestinationWeather
  attr_reader :temperature, :conditions

  def initialize(data, time)
    @temperature = time[0] <= 48 ? data[:hourly][time[0]][:temp].round(1) : daily_weather_temp(data, time)
    @conditions = time[0] <= 48 ? data[:hourly][time[0]][:weather][0][:description] : daily_weather_conditions(data, time)
  end

  def daily_weather_temp(data, time)
    daily_time = (time[0] / 24).round
    data[:daily][daily_time][:temp][:day].round(1)
  end

  def daily_weather_conditions(data, time)
    daily_time = (time[0] / 24).round
    data[:daily][daily_time][:weather][0][:description]
  end
end
