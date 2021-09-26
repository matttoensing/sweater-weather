require 'rails_helper'

RSpec.describe GeocodeFacade do
  it 'can create a location', :vcr do
    location = GeocodeFacade.create_location('denver,co')

    expect(location).to be_an_instance_of(Location)
  end
end
