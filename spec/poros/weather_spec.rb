require 'rails_helper'

 RSpec.describe Weather do
   it 'exists and has attributes' do
     response = File.read('spec/fixtures/weather_attributes.json')

     attributes = JSON.parse(response, symbolize_names: true)

     weather = Weather.new(attributes)

     expect(weather).to be_an_instance_of(Weather)
     expect(weather.current_temp).to eq(75.2)
     expect(weather.current_conditions).to eq('Sunny')
     expect(weather.current_conditions)image).to eq('//cdn.weatherapi.com/weather/64x64/day/113.png')
     expect(weather.humidity).to eq(18)
     expect(weather.visibility).to eq(9.0)
     
   end
 end
