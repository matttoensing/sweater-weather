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
    @sunrise = format_time(info[:sunrise]).to_s
    @sunset = format_time(info[:sunset]).to_s
    @max_temp = info[:temp][:max].round(1)
    @min_temp = info[:temp][:min].round(1)
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
