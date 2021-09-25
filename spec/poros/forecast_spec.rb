require 'rails_helper'

 RSpec.describe Forecast do
   it 'exists and has attributes' do
     response = File.read('spec/fixtures/weather_attributes.json')

     attributes = JSON.parse(response, symbolize_names: true)

     weather = Forecast.new(attributes)

     expect(weather).to be_an_instance_of(Forecast)
     expect(weather.id).to eq(nil)

     expect(weather.current_weather).to be_an_instance_of(CurrentWeather)

     expect(weather.daily_weather.count).to eq(5)
     weather.daily_weather.each do |daily|
       expect(daily).to be_an_instance_of(DailyWeather)
     end

     expect(weather.hourly_weather.count).to eq(8)
     weather.hourly_weather.each do |hourly|
       expect(hourly).to be_an_instance_of(HourlyWeather)
     end
   end
 end
