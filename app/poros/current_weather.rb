class CurrentWeather
  attr_reader :datetime,
              :temperature,
              :humidity,
              :feels_like,
              :uvi,
              :visibility,
              :sunrise,
              :sunset


  def initialize(info)
    @datetime = format_time(info[:current][:dt])
    @temperature = info[:current][:temp]
    @humidity = info[:current][:humidity]
    @feels_like = info[:current][:feelslike]
    @uvi = info[:current][:uvi]
    @visibility = info[:current][:visibility]
    @sunrise = format_time(info[:current][:sunrise])
    @sunset = format_time(info[:current][:sunset])
  end

  def format_time(time)
    Time.at(time)
  end
end
