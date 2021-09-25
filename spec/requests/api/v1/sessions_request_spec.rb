require 'rails_helper'

 RSpec.describe Api::V1::SessionsController, :type => :controller do
   describe 'happy path' do
     it 'can authenticate a user when the user requests to login' do
       user = create(:user)

       user_body = {
         email: user.email,
         password: user.password,
         password_confirmation: user.password
       }

       headers = {"CONTENT_TYPE" => "application/json", "Accept": "application/json"}

       post :create, params: {}, body: user_body.to_json, as: :json

       expect(response).to be_successful
       # expect(response.status).to eq(200)

       json = JSON.parse(response.body, symbolize_names: true)[:data]

       expect(json).to have_key(:type)
       expect(json).to have_key(:id)
       expect(json).to have_key(:attributes)
       expect(json[:attributes]).to have_key(:email)
       expect(json[:attributes]).to have_key(:api_key)
     end
   end
 end
