require 'rails_helper'

RSpec.describe WeatherService do
  it 'can make a connection to external service' do
    connection = WeatherService.conn('https://api.openweathermap.org/data/2.5/weather')
    expect(connection).to be_an_instance_of(Faraday::Connection)
  end

  it 'can get weather infromation', :vcr do
    json = WeatherService.get_weather_info('Boulder')

    expect(json).to have_key(:location)
    expect(json[:location].class).to eq(Hash)
    expect(json[:location]).to have_key(:localtime)
    expect(json[:location][:localtime].class).to eq(String)
    expect(json).to have_key(:current)
    expect(json[:current].class).to eq(Hash)
    expect(json[:current]).to have_key(:temp_f)
    expect(json[:current][:temp_f].class).to eq(Float)
    expect(json[:current]).to have_key(:condition)
    expect(json[:current][:condition].class).to eq(Hash)
    expect(json[:current][:condition]).to have_key(:text)
    expect(json[:current][:condition][:text].class).to eq(String)
    expect(json[:current]).to have_key(:precip_in)
    expect(json[:current][:precip_in].class).to eq(Float)
    expect(json[:current]).to have_key(:feelslike_f)
    expect(json[:current][:feelslike_f].class).to eq(Float)

    # expect(json[:forecast][:forecastday].count).to eq(6)

    expect(json).to have_key(:forecast)
    expect(json[:forecast][:forecastday].class).to eq(Array)
    expect(json[:forecast][:forecastday][0]).to have_key(:date)
    expect(json[:forecast][:forecastday][0][:date].class).to eq(String)

    expect(json[:forecast][:forecastday][0][:day]).to have_key(:maxtemp_f)
    expect(json[:forecast][:forecastday][0][:day][:maxtemp_f].class).to eq(Float)
    expect(json[:forecast][:forecastday][0][:day]).to have_key(:mintemp_f)
    expect(json[:forecast][:forecastday][0][:day][:mintemp_f].class).to eq(Float)
    expect(json[:forecast][:forecastday][0][:day]).to have_key(:condition)
    expect(json[:forecast][:forecastday][0][:day][:condition].class).to eq(Hash)

    expect(json[:forecast][:forecastday][0][:day][:condition]).to have_key(:text)
    expect(json[:forecast][:forecastday][0][:day][:condition][:text].class).to eq(String)
    expect(json[:forecast][:forecastday][0][:day][:condition]).to have_key(:icon)
    expect(json[:forecast][:forecastday][0][:day][:condition][:icon].class).to eq(String)

    expect(json[:forecast][:forecastday][0]).to have_key(:hour)
    expect(json[:forecast][:forecastday][0][:hour].class).to eq(Array)
    expect(json[:forecast][:forecastday][0][:hour][0]).to have_key(:temp_f)
    expect(json[:forecast][:forecastday][0][:hour][0][:temp_f].class).to eq(Float)
    expect(json[:forecast][:forecastday][0][:hour][0]).to have_key(:condition)
    expect(json[:forecast][:forecastday][0][:hour][0][:condition]).to have_key(:text)
    expect(json[:forecast][:forecastday][0][:hour][0][:condition][:text].class).to eq(String)

    expect(json[:forecast][:forecastday][0][:hour][0][:condition]).to have_key(:icon)
    expect(json[:forecast][:forecastday][0][:hour][0][:condition][:text].class).to eq(String)
  end
end
