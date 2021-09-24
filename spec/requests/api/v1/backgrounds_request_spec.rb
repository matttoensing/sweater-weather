require 'rails_helper'

 RSpec.describe 'backgrounds API' do
   it 'can send a background image for a specific location', :vcr do
     get '/api/v1/backgrounds', params: { location: 'denver,co'}

     expect(response).to be_successful

     image = JSON.parse(response.body, symbolize_names: true)[:data]

     expect(image).to have_key(:id)
     expect(image).to have_key(:type)
     expect(image).to have_key(:attributes)
     expect(image[:attributes]).to have_key(:image_url)
     expect(image[:attributes]).to have_key(:location)
     expect(image[:attributes]).to have_key(:author)
     expect(image[:attributes]).to have_key(:author_url)
     expect(image[:attributes]).to have_key(:source)
   end
 end
