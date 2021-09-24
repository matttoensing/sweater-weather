require 'rails_helper'

 RSpec.describe CurrentWeather do
   it 'exists and has attributes' do
     attributes =  {
       lat: 34.2809,
       lon: -114.1838,
       timezone: "America/Los_Angeles",
       timezone_offset: -25200,
       current: {
        dt: 1632493086,
        sunrise: 1632489985,
        sunset: 1632533450,
        temp: 299.01,
        feels_like: 298.88,
        pressure: 1012,
        humidity: 47,
        dew_point: 286.85,
        uvi: 0,
        clouds: 42,
        visibility: 10000,
        wind_speed: 1.72,
        wind_deg: 47,
        wind_gust: 1.91,
        weather: [
            {
                id: 802,
                main: "Clouds",
                description: "scattered clouds",
                icon: "03d"
            }
        ]
    }}

      current_weather = CurrentWeather.new(attributes)

      expect(current_weather).to be_an_instance_of(CurrentWeather)
      expect(current_weather.datetime).to eq(Time.at(attributes[:current][:dt]))
      expect(current_weather.temperature).to eq(attributes[:current][:temp])
      expect(current_weather.humidity).to eq(attributes[:current][:humidity])
      expect(current_weather.feels_like).to eq(attributes[:current][:feelslike])
      expect(current_weather.uvi).to eq(attributes[:current][:uvi])
      expect(current_weather.visibility).to eq(attributes[:current][:visibility])
      expect(current_weather.sunset).to eq(Time.at(attributes[:current][:sunset]))
      expect(current_weather.sunrise).to eq(Time.at(attributes[:current][:sunrise]))
   end
 end
