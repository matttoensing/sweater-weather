require 'rails_helper'

 RSpec.describe 'book search api' do
   describe 'happy paths' do
     it 'sends a list of books based on location and quantitity params', :vcr do
       get '/api/v1/book-search', params: {location: 'denver,co', quantity: 5}

       expect(response).to be_successful

       books = JSON.parse(response.body, symbolize_names: true)[:data]

       expect(books).to have_key(:id)
       expect(books[:id]).to eq(nil)
       expect(books).to have_key(:type)
       expect(books[:type]).to eq('books')
       expect(books).to have_key(:attributes)
       expect(books[:attributes]).to have_key(:destination)
       expect(books[:attributes]).to have_key(:forecast)
       expect(books[:attributes][:forecast]).to have_key(:summary)
       expect(books[:attributes][:forecast]).to have_key(:temperature)
       expect(books[:attributes]).to have_key(:total_books_found)
       expect(books[:attributes]).to have_key(:books)
       expect(books[:attributes][:books].count).to eq(5)
       expect(books[:attributes][:books][0]).to have_key(:isbn)
       expect(books[:attributes][:books][0]).to have_key(:title)
       expect(books[:attributes][:books][0]).to have_key(:publisher)
     end

     it 'sends specific data types in response', :vcr do
       get '/api/v1/book-search', params: {location: 'denver,co', quantity: 5}

       expect(response).to be_successful

       books = JSON.parse(response.body, symbolize_names: true)[:data]

       expect(books[:id].class).to eq(NilClass)
       expect(books[:type].class).to eq(String)
       expect(books[:attributes].class).to eq(Hash)
       expect(books[:attributes][:destination].class).to eq(String)
       expect(books[:attributes][:forecast].class).to eq(Hash)
       expect(books[:attributes][:forecast][:summary].class).to eq(String)
       expect(books[:attributes][:forecast][:temperature].class).to eq(String)
       expect(books[:attributes][:total_books_found].class).to eq(Integer)
       expect(books[:attributes][:books].class).to eq(Array)
       expect(books[:attributes][:books][0][:isbn].class).to eq(Array)
       expect(books[:attributes][:books][0][:title].class).to eq(String)
       expect(books[:attributes][:books][0][:publisher].class).to eq(Array)
     end

     describe 'sad paths' do
       it 'will a bad request error if location is missing', :vcr do
         get '/api/v1/book-search', params: { quantity: 5 }

         expect(response).to_not be_successful
         expect(response.status).to eq(400)

         error = JSON.parse(response.body, symbolize_names: true)

         expect(error).to have_key(:error)
         expect(error).to have_key(:message)
       end

       it 'will a bad request error if quantity is missing', :vcr do
         get '/api/v1/book-search', params: { location: 'denver,co' }

         expect(response).to_not be_successful
         expect(response.status).to eq(400)

         error = JSON.parse(response.body, symbolize_names: true)

         expect(error).to have_key(:error)
         expect(error).to have_key(:message)
       end

       it 'will a bad request error if both quantity and location params are missing', :vcr do
         get '/api/v1/book-search', params: {}

         expect(response).to_not be_successful
         expect(response.status).to eq(400)

         error = JSON.parse(response.body, symbolize_names: true)

         expect(error).to have_key(:error)
         expect(error).to have_key(:message)
       end
     end
   end
 end
