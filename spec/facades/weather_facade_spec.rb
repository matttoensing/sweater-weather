require 'rails_helper'

 RSpec.describe WeatherFacade do
   it 'can create weather objects', :vcr do
     weather = WeatherFacade.create_weather('Boulder')

     expect(weather).to be_an_instance_of(Weather)
   end
 end
