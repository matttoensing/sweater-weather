class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(info)
    @date = format_time(info[:dt]).strftime('%F')
    @sunrise = format_time(info[:sunrise])
    @sunset = format_time(info[:sunset])
    @max_temp = info[:temp][:max]
    @min_temp = info[:temp][:min]
    @conditions = info[:weather][0][:description]
    @icon = format_icon(info[:weather][0][:icon])
  end

  def format_icon(icon)
    "http://openweathermap.org/img/w/#{icon}.png"
  end

  def format_time(time)
    Time.at(time)
  end
end
