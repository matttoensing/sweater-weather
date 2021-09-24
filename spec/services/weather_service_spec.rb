require 'rails_helper'

RSpec.describe WeatherService do
  it 'can make a connection to external service' do
    connection = WeatherService.conn('https://api.openweathermap.org/data/2.5/weather')
    expect(connection).to be_an_instance_of(Faraday::Connection)
  end

  it 'can get weather infromation', :vcr do
    json = WeatherService.get_weather_info('34.28088', '-114.18384')

    # expect(json).to have_key(:location)
    # expect(json[:location].class).to eq(Hash)
    # expect(json[:location]).to have_key(:localtime)
    # expect(json[:location][:localtime].class).to eq(String)


    expect(json).to have_key(:current)
    expect(json[:current].class).to eq(Hash)
    expect(json[:current]).to have_key(:temp)
    expect(json[:current][:temp].class).to eq(Float)

    expect(json[:current]).to have_key(:sunrise)
    expect(json[:current][:sunrise].class).to eq(Integer)
    expect(json[:current]).to have_key(:sunset)
    expect(json[:current][:sunset].class).to eq(Integer)
    expect(json[:current]).to have_key(:feels_like)
    expect(json[:current][:feels_like].class).to eq(Float)
    expect(json[:current]).to have_key(:humidity)
    expect(json[:current][:humidity].class).to eq(Integer)
    expect(json[:current]).to have_key(:uvi)
    expect(json[:current][:uvi].class).to eq(Float)
    expect(json[:current]).to have_key(:visibility)
    expect(json[:current][:visibility].class).to eq(Integer)
    expect(json[:current]).to have_key(:weather)
    expect(json[:current][:weather].class).to eq(Array)
    expect(json[:current][:weather][0]).to have_key(:description)
    expect(json[:current][:weather][0][:description].class).to eq(String)
    expect(json[:current][:weather][0]).to have_key(:icon)
    expect(json[:current][:weather][0][:icon].class).to eq(String)

    expect(json).to have_key(:hourly)
    expect(json[:hourly].class).to eq(Array)
    expect(json[:hourly][0]).to have_key(:dt)
    expect(json[:hourly][0][:dt].class).to eq(Integer)
    expect(json[:hourly][0]).to have_key(:temp)
    expect(json[:hourly][0][:temp].class).to eq(Float)
    expect(json[:hourly][0]).to have_key(:weather)
    expect(json[:hourly][0][:weather].class).to eq(Array)
    expect(json[:hourly][0][:weather][0]).to have_key(:description)
    expect(json[:hourly][0][:weather][0][:description].class).to eq(String)
    expect(json[:hourly][0][:weather][0]).to have_key(:icon)
    expect(json[:hourly][0][:weather][0][:icon].class).to eq(String)

    expect(json).to have_key(:daily)
    expect(json[:daily].class).to eq(Array)
    expect(json[:daily][0]).to have_key(:dt)
    expect(json[:daily][0][:dt].class).to eq(Integer)
    expect(json[:daily][0]).to have_key(:sunrise)
    expect(json[:daily][0][:sunrise].class).to eq(Integer)
    expect(json[:daily][0]).to have_key(:sunset)
    expect(json[:daily][0][:sunset].class).to eq(Integer)
    expect(json[:daily][0]).to have_key(:temp)
    expect(json[:daily][0][:temp].class).to eq(Hash)
    expect(json[:daily][0][:temp]).to have_key(:min)
    expect(json[:daily][0][:temp][:min].class).to eq(Float)
    expect(json[:daily][0][:temp]).to have_key(:max)
    expect(json[:daily][0][:temp][:max].class).to eq(Float)
    expect(json[:daily][0]).to have_key(:weather)
    expect(json[:daily][0][:weather].class).to eq(Array)
    expect(json[:daily][0][:weather][0]).to have_key(:description)
    expect(json[:daily][0][:weather][0][:description].class).to eq(String)
    expect(json[:daily][0][:weather][0]).to have_key(:icon)
    expect(json[:daily][0][:weather][0][:icon].class).to eq(String)
  end
end
