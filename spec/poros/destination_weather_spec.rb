require 'rails_helper'

 RSpec.describe DestinationWeather do
   it 'exists and has attributes' do
     response = File.read('spec/fixtures/destination_weather.json')

     attributes = JSON.parse(response, symbolize_names: true)


    destination_weather = DestinationWeather.new(attributes, [0, 34, 1])

    expect(destination_weather).to be_an_instance_of(DestinationWeather)
    expect(destination_weather.temperature).to eq(attributes[:hourly][0][:temp].round(1))
    expect(destination_weather.conditions).to eq(attributes[:hourly][0][:weather][0][:description])
   end

   it 'will show daily weather if time argument is greater than 48' do
     response = File.read('spec/fixtures/destination_weather.json')

     attributes = JSON.parse(response, symbolize_names: true)


    destination_weather = DestinationWeather.new(attributes, [50, 34, 1])

    expect(destination_weather).to be_an_instance_of(DestinationWeather)
    expect(destination_weather.temperature).to eq(attributes[:daily][2][:temp][:day].round(1))
    expect(destination_weather.conditions).to eq(attributes[:daily][2][:weather][0][:description])
   end
 end
