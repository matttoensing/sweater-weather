require 'rails_helper'

 RSpec.describe Image do
   it 'exists and has attributes' do
     response = File.read('spec/fixtures/image_attributes.json')

     attributes = JSON.parse(response, symbolize_names: true)
     image = Image.new(attributes)

     expect(image).to be_an_instance_of(Image)
     expect(image.id).to eq(nil)
     expect(image.image_url).to eq(attributes[:results][0][:urls][:full])
     expect(image.author).to eq(attributes[:results][0][:user][:name])
     expect(image.author_url).to eq(attributes[:results][0][:user][:portfolio_url])
     expect(image.source).to eq('unsplash.com')
   end
 end
