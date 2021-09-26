class CurrentWeather
  attr_reader :datetime,
              :conditions,
              :temperature,
              :humidity,
              :feels_like,
              :uvi,
              :visibility,
              :sunrise,
              :sunset

  def initialize(data)
    @datetime = format_time(data[:current][:dt]).to_s
    @conditions = data[:current][:weather][0][:description]
    @temperature = data[:current][:temp].round(1)
    @humidity = data[:current][:humidity]
    @feels_like = data[:current][:feels_like].round(1)
    @uvi = data[:current][:uvi]
    @visibility = data[:current][:visibility]
    @sunrise = format_time(data[:current][:sunrise]).to_s
    @sunset = format_time(data[:current][:sunset]).to_s
  end

  def format_time(time)
    Time.at(time)
  end
end
