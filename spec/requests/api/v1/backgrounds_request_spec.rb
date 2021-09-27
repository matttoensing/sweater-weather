require 'rails_helper'

RSpec.describe 'backgrounds API' do
  describe 'happy path' do
    it 'can send a background image for a specific location', :vcr do
      get '/api/v1/backgrounds', params: { location: 'denver,co' }

      expect(response).to be_successful

      image = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(image).to have_key(:id)
      expect(image[:id].class).to eq(NilClass)
      expect(image).to have_key(:type)
      expect(image[:type].class).to eq(String)
      expect(image).to have_key(:attributes)
      expect(image[:attributes].class).to eq(Hash)
      expect(image[:attributes]).to have_key(:image_url)
      expect(image[:attributes][:image_url].class).to eq(String)
      expect(image[:attributes]).to have_key(:location)
      expect(image[:attributes][:location].class).to eq(String)
      expect(image[:attributes]).to have_key(:author)
      expect(image[:attributes][:author].class).to eq(String)
      expect(image[:attributes]).to have_key(:author_url)
      expect(image[:attributes][:author_url].class).to eq(String)
      expect(image[:attributes]).to have_key(:source)
      expect(image[:attributes][:source].class).to eq(String)
    end
  end

  describe 'sad path' do
    it 'will throw an error if no location is present' do
      get '/api/v1/backgrounds'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:error)
      expect(error).to have_key(:message)
    end

    it 'will throw an error if no location is found', :vcr do
      get '/api/v1/backgrounds', params: { location: 'lakjfbiw09yqwekjfbqwef90h' }

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:error)
      expect(error).to have_key(:message)
    end
  end
end
