require 'rails_helper'

RSpec.describe HourlyWeather do
  it 'exists and has attributes' do
    attributes = {
      dt: 1_632_492_000,
      temp: 299.01,
      feels_like: 298.88,
      pressure: 1012,
      humidity: 47,
      dew_point: 286.85,
      uvi: 0,
      clouds: 42,
      visibility: 10_000,
      wind_speed: 1.72,
      wind_deg: 47,
      wind_gust: 1.91,
      weather: [
        {
          id: 802,
          main: 'Clouds',
          description: 'scattered clouds',
          icon: '03d'
        }
      ],
      pop: 0.19
    }

    hourly_weather = HourlyWeather.new(attributes)

    expect(hourly_weather).to be_an_instance_of(HourlyWeather)
    expect(hourly_weather.time).to eq(Time.at(attributes[:dt]).strftime('%T'))
    expect(hourly_weather.temperature).to eq(attributes[:temp].round(1))
    expect(hourly_weather.conditions).to eq(attributes[:weather][0][:description])
    expect(hourly_weather.icon).to eq('http://openweathermap.org/img/w/03d.png')
  end
end
