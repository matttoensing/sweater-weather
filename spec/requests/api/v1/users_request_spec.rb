require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'happy path' do
    it 'can register a new user' do
      user_body = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      expect(User.count).to eq(0)

      post :create, params: {}, body: user_body.to_json, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(User.count).to eq(1)

      user = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(user).to have_key(:type)
      expect(user).to have_key(:id)
      expect(user).to have_key(:attributes)
      expect(user[:attributes]).to have_key(:email)
      expect(user[:attributes][:email]).to eq('whatever@example.com')
      expect(user[:attributes]).to have_key(:api_key)
    end
  end

  describe 'sad path' do
    it 'will not register a new user if the passwords are not correct' do
      user_body = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'Password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: user_body.to_json, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
    end

    it 'will not register a new user if request body is empty' do
      user_body = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'Password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
    end

    it 'will not register a new user if email has already been taken' do
      user = create(:user)

      user_body = {
        email: user.email,
        password: 'password',
        password_confirmation: 'Password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
    end

    it 'will not register a new user if a field is missing' do
      user_body = {
        email: 'whatever@example.com',
        password: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
    end
  end
end
