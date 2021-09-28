require 'rails_helper'

RSpec.describe Api::V1::RoadtripController, type: :controller do
  describe 'happy path' do
    it 'can send information about a road trip', :vcr do
      user = create(:user)

      request_body = {
        origin: 'Denver,CO',
        destination: 'Pueblo,CO',
        api_key: user.api_key
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: request_body.to_json, as: :json

      expect(response).to be_successful

      road_trip = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(road_trip).to have_key(:id)
      expect(road_trip[:id]).to eq(nil)
      expect(road_trip[:type]).to eq('roadtrip')
      expect(road_trip).to have_key(:attributes)
      expect(road_trip[:attributes]).to have_key(:start_city)
      expect(road_trip[:attributes]).to have_key(:end_city)
      expect(road_trip[:attributes]).to have_key(:travel_time)
      expect(road_trip[:attributes]).to have_key(:weather_at_eta)
      expect(road_trip[:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(road_trip[:attributes][:weather_at_eta]).to have_key(:conditions)
    end

    it 'sends out data of specific data types', :vcr do
      user = create(:user)

      request_body = {
        origin: 'Denver,CO',
        destination: 'Pueblo,CO',
        api_key: user.api_key
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: request_body.to_json, as: :json

      expect(response).to be_successful

      road_trip = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(road_trip[:id].class).to eq(NilClass)
      expect(road_trip[:type].class).to eq(String)
      expect(road_trip[:attributes].class).to eq(Hash)
      expect(road_trip[:attributes][:start_city].class).to eq(String)
      expect(road_trip[:attributes][:end_city].class).to eq(String)
      expect(road_trip[:attributes][:travel_time].class).to eq(String)
      expect(road_trip[:attributes][:weather_at_eta].class).to eq(Hash)
      expect(road_trip[:attributes][:weather_at_eta][:temperature].class).to eq(Float)
      expect(road_trip[:attributes][:weather_at_eta][:conditions].class).to eq(String)
    end
  end

  describe 'sad path' do
    it 'can will not send information about a road trip if the users api key is invalid', :vcr do
      user = create(:user)

      request_body = {
        origin: 'Denver,CO',
        destination: 'Pueblo,CO',
        api_key: 'p98sdchpas98cd'
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: request_body.to_json, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
    end

    it 'can will not send information about a road trip if the origin is not present', :vcr do
      user = create(:user)

      request_body = {
        destination: 'Pueblo,CO',
        api_key: user.api_key
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: request_body.to_json, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:error)
      expect(error).to have_key(:message)
    end

    it 'can will not send information about a road trip if the destination is not present', :vcr do
      user = create(:user)

      request_body = {
        origin: 'Denver,CO',
        api_key: user.api_key
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: request_body.to_json, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:error)
      expect(error).to have_key(:message)
    end

    it 'can will not send information about a road trip if the there is no route between origin and destination', :vcr do
      user = create(:user)

      request_body = {
        origin: 'Denver,CO',
        destination: 'london',
        api_key: user.api_key
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: request_body.to_json, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:error)
      expect(error).to have_key(:message)
    end
  end
end
