require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'happy path' do
    it 'can authenticate a user when the user requests to login' do
      user = create(:user)

      user_body = {
        email: user.email,
        password: user.password,
        password_confirmation: user.password
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: user_body.to_json, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(json).to have_key(:type)
      expect(json).to have_key(:id)
      expect(json).to have_key(:attributes)
      expect(json[:attributes]).to have_key(:email)
      expect(json[:attributes]).to have_key(:api_key)
    end

    it 'sends out data of specific data types' do
      user = create(:user)

      user_body = {
        email: user.email,
        password: user.password,
        password_confirmation: user.password
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: user_body.to_json, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(json[:type].class).to eq(String)
      expect(json[:id].class).to eq(String)
      expect(json[:attributes].class).to eq(Hash)
      expect(json[:attributes][:email].class).to eq(String)
      expect(json[:attributes][:api_key].class).to eq(String)
    end
  end

  describe 'sad path' do
    it 'will send an error response if users password is invalid' do
      user = create(:user)

      user_body = {
        email: user.email,
        password: 'asdfasdfasdf'
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: user_body.to_json, as: :json

      expect(response).to_not be_successful

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:error)
      expect(error).to have_key(:message)
    end

    it 'will send an error response if users email is invalid' do
      user = create(:user)

      user_body = {
        email: 'test@test.com',
        password: user.password
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: user_body.to_json, as: :json

      expect(response).to_not be_successful

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
    end

    it 'will send an error response if users password and email are invalid' do
      user = create(:user)

      user_body = {
        email: 'test@test.com',
        password: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept": 'application/json' }

      post :create, params: {}, body: user_body.to_json, as: :json

      expect(response).to_not be_successful

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
    end
  end
end
