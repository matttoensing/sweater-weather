require 'rails_helper'

RSpec.describe Api::V1::UsersController, :type => :controller do
  it 'can register a new user' do
    user_body = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    }


    headers = {"CONTENT_TYPE" => "application/json", "Accept": "application/json"}

    post :create, params: {}, body: user_body.to_json, as: :json

    expect(response).to be_successful
    expect(response.status).to eq(201)

    user = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(user).to have_key(:type)
    expect(user).to have_key(:id)
    expect(user).to have_key(:attributes)
    expect(user[:attributes]).to have_key(:email)
    expect(user[:attributes][:email]).to eq("whatever@example.com")
    expect(user[:attributes]).to have_key(:api_key)
  end

  it 'will not register a new user if the passwords are not correct' do
    user_body = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "Password"
    }


    headers = {"CONTENT_TYPE" => "application/json", "Accept": "application/json"}

    post :create, params: {}, body: user_body.to_json, as: :json

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    # user = JSON.parse(response.body, symbolize_names: true)[:data]
    #
    # expect(user).to have_key(:type)
    # expect(user).to have_key(:id)
    # expect(user).to have_key(:attributes)
    # expect(user[:attributes]).to have_key(:email)
    # expect(user[:attributes][:email]).to eq("whatever@example.com")
    # expect(user[:attributes]).to have_key(:api_key)
  end
end
