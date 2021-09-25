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

   it 'can get information for directions between two locations', :vcr do
     json = GeocodeService.get_directions_info('boulder,co', 'denver,co')

     expect(json).to have_key(:route)
     expect(json[:route].class).to eq(Hash)
     expect(json[:route]).to have_key(:formattedTime)
     expect(json[:route][:formattedTime].class).to eq(String)


     expect(json[:route]).to have_key(:locations)
     expect(json[:route][:locations].class).to eq(Array)
     expect(json[:route][:locations][0]).to have_key(:adminArea5)
     expect(json[:route][:locations][0][:adminArea5].class).to eq(String)
     expect(json[:route][:locations][0]).to have_key(:adminArea3)
     expect(json[:route][:locations][0][:adminArea3].class).to eq(String)
   end
 end
