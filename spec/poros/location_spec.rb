require 'rails_helper'

 RSpec.describe Location do
   it 'exists and has attributes' do
     response = File.read('spec/fixtures/geocode_response.json')

     attributes = JSON.parse(response, symbolize_names: true)

     location = Location.new(attributes)

     expect(location).to be_an_instance_of(Location)
     expect(location.latitude).to eq(39.738453)
     expect(location.longitude).to eq(-104.984853)
   end
 end
