require 'rails_helper'

 RSpec.describe DestinationWeather do
   it 'exists and has attributes' do
     attributes = {
    lat: 34.2809,
    lon: -114.1838,
    timezone: "America/Los_Angeles",
    timezone_offset: -25200,
    current: {
        dt: 1632612004,
        sunrise: 1632576427,
        sunset: 1632619765,
        temp: 89.62,
        feels_like: 86.92,
        pressure: 1010,
        humidity: 27,
        dew_point: 51.24,
        uvi: 1.83,
        clouds: 85,
        visibility: 10000,
        wind_speed: 6.26,
        wind_deg: 204,
        wind_gust: 6.69,
        weather: [
            {
                id: 804,
                main: "Clouds",
                description: "overcast clouds",
                icon: "04d"
            }
        ]
    }}

    destination_weather = DestinationWeather.new(attributes)

    expect(destination_weather).to be_an_instance_of(DestinationWeather)
    expect(destination_weather.temperature).to eq(attributes[:current][:temp].round(1))
    expect(destination_weather.conditions).to eq(attributes[:current][:weather][0][:description])
   end
 end
