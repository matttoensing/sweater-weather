require 'rails_helper'

 RSpec.describe Image do
   it 'exists and has attributes' do
     response = File.read('spec/fixtures/image_attributes.json')

     attributes = JSON.parse(response, symbolize_names: true)
     image = Image.new(attributes)

     expect(image).to be_an_instance_of(Image)
     expect(image.id).to eq(nil)
   end
 end
