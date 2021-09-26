require 'rails_helper'

 RSpec.describe Roadtrip do
   it 'exists and has attributes' do
     attributes = {
      start_city: "Denver, CO",
      end_city: "Estes Park, CO",
      travel_time: "2 hours, 13 minutes",
      weather_at_eta: {
        temperature: 59.4,
        conditions: "partly cloudy with a chance of meatballs"
      }
    }

    roadtrip = Roadtrip.new(attributes)

    expect(roadtrip).to be_an_instance_of(Roadtrip)
    expect(roadtrip.id).to eq(nil)
    expect(roadtrip.start_city).to eq(attributes[:start_city])
    expect(roadtrip.end_city).to eq(attributes[:end_city])
    expect(roadtrip.travel_time).to eq(attributes[:travel_time])
    expect(roadtrip.weather_at_eta).to eq(attributes[:weather_at_eta])
   end
 end
