require 'rails_helper'

 RSpec.describe CurrentWeather do
   it 'exists and has attributes' do
     attributes = {
       location: {
         localtime: "2021-09-23 18:49"
       },
       current: {
         temp_f: 75.2,
         humidity: 18,
         feelslike_f: 73.7,
         vis_miles: 9.0,
         uv: 7.0,
         condition: {
           text: 'Sunny',
           icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"
         }
       },
       forecast: {
         forecastday: [
           {
             astro: {
               sunrise: "06:50 AM",
               sunset: "06:56 PM"
             }
           }
         ]
       }
     }

      current_weather = CurrentWeather.new(attributes)

      expect(current_weather).to be_an_instance_of(CurrentWeather)
      expect(current_weather.datetime).to eq(attributes[:location][:localtime])
      expect(current_weather.temperature).to eq(attributes[:current][:temp_f])
      expect(current_weather.humidity).to eq(attributes[:current][:humidity])
      expect(current_weather.feels_like).to eq(attributes[:current][:feelslike_f])
      expect(current_weather.uvi).to eq(attributes[:current][:uv])
      expect(current_weather.visibility).to eq(attributes[:current][:vis_miles])
      expect(current_weather.sunset).to eq(attributes[:forecast][:forecastday][0][:astro][:sunset])
      expect(current_weather.sunrise).to eq(attributes[:forecast][:forecastday][0][:astro][:sunrise])
   end
 end
