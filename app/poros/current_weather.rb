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
    @datetime = info[:location][:localtime]
    @temperature = info[:current][:temp_f]
    @humidity = info[:current][:humidity]
    @feels_like = info[:current][:feelslike_f]
    @uvi = info[:current][:uv]
    @visibility = info[:current][:vis_miles]
    @sunrise = info[:forecast][:forecastday][0][:astro][:sunrise]
    @sunset = info[:forecast][:forecastday][0][:astro][:sunset]
  end
end
