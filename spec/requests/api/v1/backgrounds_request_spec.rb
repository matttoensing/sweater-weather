require 'rails_helper'

RSpec.describe 'backgrounds API' do
  describe 'happy path' do
    it 'can send a background image for a specific location', :vcr do
      get '/api/v1/backgrounds', params: { location: 'denver,co' }

      expect(response).to be_successful

      image = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(image).to have_key(:id)
      expect(image).to have_key(:type)
      expect(image).to have_key(:attributes)
      expect(image[:attributes]).to have_key(:image_url)
      expect(image[:attributes]).to have_key(:location)
      expect(image[:attributes]).to have_key(:description)
      expect(image[:attributes]).to have_key(:credit)
      expect(image[:attributes][:credit]).to have_key(:photographer)
      expect(image[:attributes][:credit]).to have_key(:author_profile_url)
      expect(image[:attributes][:credit]).to have_key(:author_url)
      expect(image[:attributes][:credit]).to have_key(:source)
    end

    it 'sends specific data back to the client', :vcr do
      get '/api/v1/backgrounds', params: { location: 'denver,co' }

      expect(response).to be_successful

      image = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(image[:id].class).to eq(NilClass)
      expect(image[:type].class).to eq(String)
      expect(image[:attributes].class).to eq(Hash)
      expect(image[:attributes][:image_url].class).to eq(String)
      expect(image[:attributes][:location].class).to eq(String)
      expect(image[:attributes][:description].class).to eq(String)
      expect(image[:attributes][:credit].class).to eq(Hash)
      expect(image[:attributes][:credit][:photographer].class).to eq(String)
      expect(image[:attributes][:credit][:author_profile_url].class).to eq(String)
      expect(image[:attributes][:credit][:author_url].class).to eq(String)
      expect(image[:attributes][:credit][:source].class).to eq(String)
    end
  end

  it 'does not send all data back to client', :vcr do
    get '/api/v1/backgrounds', params: { location: 'denver,co' }

    expect(response).to be_successful

    image = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(image).to_not have_key(:created_at)
    expect(image).to_not have_key(:updated_at)
    expect(image).to_not have_key(:description)
    expect(image).to_not have_key(:links)
    expect(image).to_not have_key(:likes)
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
