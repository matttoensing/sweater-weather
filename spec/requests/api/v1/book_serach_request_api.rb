require 'rails_helper'

 RSpec.describe 'book search api' do
   describe 'happy paths' do
     it 'sends a list of books based on location and quantitity params' do
       get '/api/v1/book-search', params: {location: 'denver,co', quantity: 5}

       expect(response).to be_successful

       books = JSON.parse(response.body, symbolize_names: true)[:data]

       expect(books).to have_key(:id)
       expect(books[:id].class).to eq(NilClass)
       expect(books).to have_key(:type)
       expect(books[:type].class).to eq(String)
       expect(books).to have_key(:attributes)
       expect(books[:attributes].class).to eq(Hash)
       expect(books[:attributes]).to have_key(:destination)
       expect(books[:attributes]).to have_key(:forecast)
       expect(books[:attributes][:forecast]).to have_key(:summary)
       expect(books[:attributes][:forecast]).to have_key(:temperature)
       expect(books[:attributes]).to have_key(:total_books_found)
       expect(books[:attributes]).to have_key(:books)
       expect(books[:attributes][:books].class).to eq(Array)
       expect(books[:attributes][:books].count).to eq(5)
       expect(books[:attributes][:books][0]).to have_key(:isbn)
       expect(books[:attributes][:books][0]).to have_key(:title)
     end
   end
 end

 # {
 #   "data": {
 #     "id": "null",
 #     "type": "books",
 #     "attributes": {
 #       "destination": "denver,co",
 #       "forecast": {
 #         "summary": "Cloudy with a chance of meatballs",
 #         "temperature": "83 F"
 #       },
 #       "total_books_found": 172,
 #       "books": [
 #         {
 #           "isbn": [
 #             "0762507845",
 #             "9780762507849"
 #           ],
 #           "title": "Denver, Co",
 #           "publisher": [
 #             "Universal Map Enterprises"
 #           ]
 #         },
 #         {
 #           "isbn": [
 #             "9780883183663",
 #             "0883183668"
 #           ],
 #           "title": "Photovoltaic safety, Denver, CO, 1988",
 #           "publisher": [
 #             "American Institute of Physics"
 #           ]
 #         },
 #         { ... same format for books 3, 4 and 5 ... }
 #       ]
 #     }
 #   }
 # }
