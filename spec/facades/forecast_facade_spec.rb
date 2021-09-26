require 'rails_helper'

RSpec.describe ForecastFacade do
  it 'can create weather objects', :vcr do
    weather = ForecastFacade.create_weather('34.28088', '-114.18384')

    expect(weather).to be_an_instance_of(Forecast)
  end
end
