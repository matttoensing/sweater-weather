require 'rails_helper'

 RSpec.describe GeocodeService do
   it 'can retrieve information from a city', :vcr do
     json = GeocodeService.get_location_info('denver,co')

     expect(json).to have_key(:results)
     expect(json[:results].class).to eq(Array)
     expect(json[:results][0]).to have_key(:locations)
     expect(json[:results][0][:locations].class).to eq(Array)
     expect(json[:results][0][:locations][0]).to have_key(:latLng)
     expect(json[:results][0][:locations][0][:latLng]).to have_key(:lat)
     expect(json[:results][0][:locations][0][:latLng][:lat].class).to eq(Float)
     expect(json[:results][0][:locations][0][:latLng]).to have_key(:lng)
     expect(json[:results][0][:locations][0][:latLng][:lng].class).to eq(Float)
   end
 end
