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

      json = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(json).to have_key(:type)
      expect(json).to have_key(:id)
      expect(json).to have_key(:attributes)
      expect(json[:attributes]).to have_key(:email)
      expect(json[:attributes]).to have_key(:api_key)
    end

    it 'exposes data of specific data types' do
      user_body = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: user_body.to_json, as: :json

      json = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(json[:type].class).to eq(String)
      expect(json[:id].class).to eq(String)
      expect(json[:attributes].class).to eq(Hash)
      expect(json[:attributes][:email].class).to eq(String)
      expect(json[:attributes][:api_key].class).to eq(String)
    end

    it 'will not expose critical data' do
      user_body = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: user_body.to_json, as: :json

      json = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(json).to_not have_key(:password)
      expect(json).to_not have_key(:password_confirmation)
      expect(json).to_not have_key(:password_digest)
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
