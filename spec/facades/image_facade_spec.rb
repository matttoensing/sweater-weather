require 'rails_helper'

 RSpec.describe ImageFacade do
   it 'can create images', :vcr do
     image = ImageFacade.create_image('boulder,co')

     expect(image).to be_an_instance_of(Image)
   end
 end
