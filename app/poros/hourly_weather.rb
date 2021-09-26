class HourlyWeather
  attr_reader :time, :temperature, :conditions, :icon

  def initialize(info)
    @time = format_time(info[:dt])
    @temperature = info[:temp]
    @conditions = info[:weather][0][:description]
    @icon = format_icon(info[:weather][0][:icon])
  end

  def format_icon(icon)
    "http://openweathermap.org/img/w/#{icon}.png"
  end

  def format_time(time)
    Time.at(time).strftime('%T')
  end
end
