require 'rails_helper'

RSpec.describe 'weather api' do
  describe 'happy paths' do
    it 'can send weather attributes including current weather, daily weather, and hourly weather', :vcr do
      get '/api/v1/forecast', params: { location: 'denver,co'}

      expect(response).to be_successful

      weather = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(weather).to have_key(:id)
      expect(weather).to have_key(:type)
      expect(weather[:type]).to eq('forecast')
      expect(weather).to have_key(:attributes)
      expect(weather[:attributes]).to have_key(:current_weather)
      expect(weather[:attributes][:current_weather]).to have_key(:datetime)

      expect(weather[:attributes]).to have_key(:daily_weather)

      expect(weather[:attributes]).to have_key(:hourly_weather)

      expect(weather[:attributes][:current_weather]).to have_key(:temperature)
      expect(weather[:attributes][:current_weather]).to have_key(:conditions)
      expect(weather[:attributes][:current_weather]).to have_key(:humidity)
      expect(weather[:attributes][:current_weather]).to have_key(:feels_like)
      expect(weather[:attributes][:current_weather]).to have_key(:uvi)
      expect(weather[:attributes][:current_weather]).to have_key(:visibility)
      expect(weather[:attributes][:current_weather]).to have_key(:sunrise)

      expect(weather[:attributes][:daily_weather][0]).to have_key(:date)
      expect(weather[:attributes][:daily_weather][0]).to have_key(:sunrise)
      expect(weather[:attributes][:daily_weather][0]).to have_key(:sunset)
      expect(weather[:attributes][:daily_weather][0]).to have_key(:max_temp)
      expect(weather[:attributes][:daily_weather][0]).to have_key(:min_temp)
      expect(weather[:attributes][:daily_weather][0]).to have_key(:conditions)
      expect(weather[:attributes][:daily_weather][0]).to have_key(:icon)

      expect(weather[:attributes][:hourly_weather][0]).to have_key(:time)
      expect(weather[:attributes][:hourly_weather][0]).to have_key(:temperature)
      expect(weather[:attributes][:hourly_weather][0]).to have_key(:conditions)
      expect(weather[:attributes][:hourly_weather][0]).to have_key(:icon)
    end

    it 'only sends the neccessary data, and does not send what is not needed', :vcr do
      get '/api/v1/forecast', params: { location: 'denver,co'}

      expect(response).to be_successful

      weather = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(weather).to_not have_key(:moonrise)
      expect(weather).to_not have_key(:moonset)
      expect(weather).to_not have_key(:moonphase)
      expect(weather).to_not have_key(:pressure)
      expect(weather).to_not have_key(:wind_deg)
      expect(weather).to_not have_key(:wind_gust)
      expect(weather).to_not have_key(:dew_point)
    end
  end

  describe 'sad paths' do
    it 'will return an error if no location is found', :vcr do
      get '/api/v1/forecast'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:error)
      expect(error).to have_key(:message)
    end
  end
end
