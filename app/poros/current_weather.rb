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
    @datetime = info[:current][:dt]
    @temperature = info[:current][:temp]
    @humidity = info[:current][:humidity]
    @feels_like = info[:current][:feelslike]
    @uvi = info[:current][:uvi]
    @visibility = info[:current][:visibility]
    @sunrise = info[:current][:sunrise]
    @sunset = info[:current][:sunset]
  end
end
