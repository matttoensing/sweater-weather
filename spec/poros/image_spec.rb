require 'rails_helper'

RSpec.describe Image do
  it 'exists and has attributes' do
    response = File.read('spec/fixtures/image_attributes.json')

    attributes = JSON.parse(response, symbolize_names: true)
    image = Image.new(attributes, 'boulder, co')

    credit = {
        photographer: attributes[:user][:name],
        author_profile_url: attributes[:user][:links][:self],
        author_url: attributes[:user][:portfolio_url],
        source: 'unsplash.com'
    }

    expect(image).to be_an_instance_of(Image)
    expect(image.id).to eq(nil)
    expect(image.location).to eq('boulder, co')
    expect(image.description).to eq(attributes[:alt_description])
    expect(image.image_url).to eq(attributes[:urls][:full])
    expect(image.credit).to eq(credit)
  end
end
