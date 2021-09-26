require 'rails_helper'

RSpec.describe UnsplashService do
  it 'can get an image based off of a query search', :vcr do
    json = UnsplashService.get_image_results('boulder,co')

    expect(json).to have_key(:results)
    expect(json[:results].class).to eq(Array)
    expect(json[:results][0]).to have_key(:alt_description)
    expect(json[:results][0][:alt_description].class).to eq(String)

    expect(json[:results][0]).to have_key(:urls)
    expect(json[:results][0][:urls].class).to eq(Hash)
    expect(json[:results][0][:urls]).to have_key(:full)
    expect(json[:results][0][:urls][:full].class).to eq(String)

    expect(json[:results][0]).to have_key(:user)
    expect(json[:results][0][:user].class).to eq(Hash)
    expect(json[:results][0][:user]).to have_key(:name)
    expect(json[:results][0][:user][:name].class).to eq(String)
    expect(json[:results][0][:user]).to have_key(:portfolio_url)
    expect(json[:results][0][:user][:portfolio_url].class).to eq(String)
  end
end
