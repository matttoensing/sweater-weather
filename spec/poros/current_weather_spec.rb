require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'exists and has attributes' do
    attributes = {
      lat: 34.2809,
      lon: -114.1838,
      timezone: 'America/Los_Angeles',
      timezone_offset: -25_200,
      current: {
        dt: 1_632_612_004,
        sunrise: 1_632_576_427,
        sunset: 1_632_619_765,
        temp: 89.62,
        feels_like: 86.92,
        pressure: 1010,
        humidity: 27,
        dew_point: 51.24,
        uvi: 1.83,
        clouds: 85,
        visibility: 10_000,
        wind_speed: 6.26,
        wind_deg: 204,
        wind_gust: 6.69,
        weather: [
          {
            id: 804,
            main: 'Clouds',
            description: 'overcast clouds',
            icon: '04d'
          }
        ]
      }
    }

    current_weather = CurrentWeather.new(attributes)

    expect(current_weather).to be_an_instance_of(CurrentWeather)
    expect(current_weather.datetime).to eq(Time.at(attributes[:current][:dt]).to_s)
    expect(current_weather.conditions).to eq(attributes[:current][:weather][0][:description])
    expect(current_weather.temperature).to eq(attributes[:current][:temp].round(1))
    expect(current_weather.humidity).to eq(attributes[:current][:humidity])
    expect(current_weather.feels_like).to eq(attributes[:current][:feels_like].round(1))
    expect(current_weather.uvi).to eq(attributes[:current][:uvi])
    expect(current_weather.visibility).to eq(attributes[:current][:visibility])
    expect(current_weather.sunset).to eq(Time.at(attributes[:current][:sunset]).to_s)
    expect(current_weather.sunrise).to eq(Time.at(attributes[:current][:sunrise]).to_s)
  end
end
