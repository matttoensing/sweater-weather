require 'rails_helper'

 RSpec.describe DailyWeather do
   it 'exists and has attributes' do
     attributes = {
       date: '2020-10-01',
       day: {
       maxtemp_f: 84.0,
       mintemp_f: 54.3,
       condition:{
         text: 'Partly Cloudy',
       icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
     }
   },
     astro: {
       sunrise: "06:50 AM",
       sunset: "06:56 PM",
     }
   }


     daily_weather = DailyWeather.new(attributes)

     expect(daily_weather).to be_an_instance_of(DailyWeather)
     expect(daily_weather.date).to eq(attributes[:date])
     expect(daily_weather.sunrise).to eq(attributes[:astro][:sunrise])
     expect(daily_weather.sunset).to eq(attributes[:astro][:sunset])
     expect(daily_weather.max_temp).to eq(attributes[:day][:maxtemp_f])
     expect(daily_weather.min_temp).to eq(attributes[:day][:mintemp_f])
     expect(daily_weather.conditions).to eq(attributes[:day][:condition][:text])
     expect(daily_weather.icon).to eq(attributes[:day][:condition][:icon])
   end
 end
