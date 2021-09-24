require 'rails_helper'

 RSpec.describe HourlyWeather do
   it 'exists and has attributes' do
    attributes =  {
       time: "2020-10-01",
       temp_f: 64.0,
       condition: {
         text: 'Sunny',
         icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"
       }
     }

     hourly_weather = HourlyWeather.new(attributes)

     expect(hourly_weather).to be_an_instance_of(HourlyWeather)
     expect(hourly_weather.time).to eq(attributes[:time])
     expect(hourly_weather.temperature).to eq(attributes[:temp_f])
     expect(hourly_weather.conditions).to eq(attributes[:condition][:text])
     expect(hourly_weather.icon).to eq(attributes[:condition][:icon])
   end
 end
