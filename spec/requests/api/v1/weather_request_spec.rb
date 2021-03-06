require 'rails_helper'

RSpec.describe 'weather api' do
  describe 'happy paths' do
    it 'can send weather attributes including current weather, daily weather, and hourly weather', :vcr do
      get '/api/v1/forecast', params: { location: 'denver,co' }

      expect(response).to be_successful

      weather = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(weather).to have_key(:id)
      expect(weather[:id]).to eq(nil)
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
      expect(weather[:attributes][:current_weather]).to have_key(:sunset)

      weather[:attributes][:daily_weather].each do |data|
        expect(data).to have_key(:date)
        expect(data).to have_key(:sunrise)
        expect(data).to have_key(:sunset)
        expect(data).to have_key(:max_temp)
        expect(data).to have_key(:min_temp)
        expect(data).to have_key(:conditions)
        expect(data).to have_key(:icon)
      end

      weather[:attributes][:hourly_weather].each do |data|
        expect(data).to have_key(:time)
        expect(data).to have_key(:temperature)
        expect(data).to have_key(:conditions)
        expect(data).to have_key(:icon)
      end
    end

    it 'sends specific data types for the weather api', :vcr do
      get '/api/v1/forecast', params: { location: 'denver,co' }

      expect(response).to be_successful

      weather = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(weather[:id].class).to eq(NilClass)
      expect(weather[:type].class).to eq(String)
      expect(weather[:attributes].class).to eq(Hash)
      expect(weather[:attributes][:current_weather].class).to eq(Hash)
      expect(weather[:attributes][:current_weather][:datetime].class).to eq(String)

      expect(weather[:attributes][:daily_weather].class).to eq(Array)
      expect(weather[:attributes][:hourly_weather].class).to eq(Array)

      expect(weather[:attributes][:current_weather][:temperature].class).to eq(Float)
      expect(weather[:attributes][:current_weather][:conditions].class).to eq(String)
      expect(weather[:attributes][:current_weather][:humidity].class).to eq(Integer)
      expect(weather[:attributes][:current_weather][:feels_like].class).to eq(Float)
      expect(weather[:attributes][:current_weather][:uvi].class).to eq(Integer)
      expect(weather[:attributes][:current_weather][:visibility].class).to eq(Integer)
      expect(weather[:attributes][:current_weather][:sunrise].class).to eq(String)
      expect(weather[:attributes][:current_weather][:sunset].class).to eq(String)

      weather[:attributes][:daily_weather].each do |data|
        expect(data[:date].class).to eq(String)
        expect(data[:sunrise].class).to eq(String)
        expect(data[:sunset].class).to eq(String)
        expect(data[:max_temp].class).to eq(Float)
        expect(data[:min_temp].class).to eq(Float)
        expect(data[:conditions].class).to eq(String)
        expect(data[:icon].class).to eq(String)
      end

      weather[:attributes][:hourly_weather].each do |data|
        expect(data[:time].class).to eq(String)
        expect(data[:temperature].class).to eq(Float)
        expect(data[:conditions].class).to eq(String)
        expect(data[:icon].class).to eq(String)
      end
    end

    it 'only sends the neccessary data, and does not send what is not needed', :vcr do
      get '/api/v1/forecast', params: { location: 'denver,co' }

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

    it 'can send an optional param units to return metric values', :vcr do
      get '/api/v1/forecast', params: { location: 'denver,co', units: 'metric' }

      expect(response).to be_successful

      weather = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(weather).to have_key(:id)
      expect(weather[:id]).to eq(nil)
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
      expect(weather[:attributes][:current_weather]).to have_key(:sunset)

      weather[:attributes][:daily_weather].each do |data|
        expect(data).to have_key(:date)
        expect(data).to have_key(:sunrise)
        expect(data).to have_key(:sunset)
        expect(data).to have_key(:max_temp)
        expect(data).to have_key(:min_temp)
        expect(data).to have_key(:conditions)
        expect(data).to have_key(:icon)
      end

      weather[:attributes][:hourly_weather].each do |data|
        expect(data).to have_key(:time)
        expect(data).to have_key(:temperature)
        expect(data).to have_key(:conditions)
        expect(data).to have_key(:icon)
      end
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
