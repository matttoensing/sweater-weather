require 'rails_helper'

 RSpec.describe RoadtripFacade do
   it 'can format the starting location for a roadtrip', :vcr do
     expected = "Boulder, CO"

     expect(RoadtripFacade.starting_location('boulder,co', 'denver,co')).to eq(expected)
   end

   it 'can format the ending location for a roadtrip', :vcr do
     expected = "Denver, CO"

     expect(RoadtripFacade.ending_location('boulder,co', 'denver,co')).to eq(expected)
   end

   it 'can determine time correctly for a road trip', :vcr do
     expected = [0, 34, 1]

     expect(RoadtripFacade.travel_time('boulder,co', 'denver,co')).to eq(expected)
   end

   it 'can format time correctly for a road trip', :vcr do
     expected = '0 Hours, 34 Minutes'

     expect(RoadtripFacade.format_travel_time('boulder,co', 'denver,co')).to eq(expected)
   end

   it 'can create a location for a road trip end point', :vcr do
     location = RoadtripFacade.destination_location('denver,co')

     expect(location).to be_an_instance_of(Location)
     expect(location.latitude).to eq(39.738453)
     expect(location.longitude).to eq(-104.984853)
   end

   it 'can create weather for a road trip end point', :vcr do
     weather = RoadtripFacade.destination_weather('denver,co')

     expect(weather).to be_an_instance_of(DestinationWeather)
     expect(weather.temperature).to eq(84.6)
     expect(weather.conditions).to eq("clear sky")
   end

   it 'can create weather information for a road trip destination', :vcr do
     expected = {
      start_city: 'Boulder, CO',
      end_city: 'Denver, CO',
      travel_time: '0 Hours, 34 Minutes',
      weather_at_eta: {
        temperature: 84.1,
        conditions: 'clear sky'
      }
    }

     expect(RoadtripFacade.create_destination_info('boulder,co', 'denver,co')).to eq(expected)
   end

   it 'can create a road trip', :vcr do
     road_trip = RoadtripFacade.create_roadtrip('boulder,co', 'denver,co')

     expect(road_trip).to be_an_instance_of(Roadtrip)
   end
 end
