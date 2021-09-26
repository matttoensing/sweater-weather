require 'rails_helper'

RSpec.describe Api::V1::RoadtripController, :type => :controller do
  describe 'happy path' do
    it 'can send information about a road trip', :vcr do
      user = create(:user)

      request_body =  {
        origin: "Denver,CO",
        destination: "Pueblo,CO",
        api_key: user.api_key
      }

      headers = {"CONTENT_TYPE" => "application/json", "Accept": "application/json"}

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
  end

  describe 'sad path' do
    
  end
end
