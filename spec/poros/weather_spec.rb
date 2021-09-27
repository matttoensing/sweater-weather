require 'rails_helper'

 RSpec.describe Weather do
   it 'exists and has attributes' do
     attributes = {
      dt: 1632757257,
      sunrise: 1632749312,
      sunset: 1632792395,
      temp: 77.68,
      feels_like: 77.45,
      pressure: 1013,
      humidity: 49,
      dew_point: 57.02,
      uvi: 1.67,
      clouds: 32,
      visibility: 10000,
      wind_speed: 5.84,
      wind_deg: 144,
      wind_gust: 8.16,
      weather: [
          {
              id: 802,
              main: "Clouds",
              description: "scattered clouds",
              icon: "03d"
          }
      ]
  }

   weather = Weather.new(attributes)

   expect(weather).to be_an_instance_of(Weather)
   expect(weather.summary).to eq("scattered clouds")
   expect(weather.temperature).to eq("78 F")
   end
 end
