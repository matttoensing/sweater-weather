require 'rails_helper'

 RSpec.describe BookSearchFacade do
   it 'can create book instances from book service', :vcr do
     response = File.read('spec/fixtures/book_response.json')
     book_data = JSON.parse(response, symbolize_names: true)

     quantity = 5
     query = 'denver,co'
     latitude = '34.28088'
     longitute = '-114.18384'

     book_search = BookSearchFacade.create_book_search(query, quantity, latitude, longitute)

     expect(book_search).to be_an_instance_of(BookSearch)
     expect(book_search.destination).to eq(query)
     expect(book_search.forecast).to be_an_instance_of(Weather)
     expect(book_search.forecast.summary).to eq("scattered clouds")
     expect(book_search.forecast.temperature).to eq(79.8)
     expect(book_search.total_books_found).to eq(book_data[:numFound])

     book_search.books.each do |book|
       expect(book).to be_an_instance_of(Book)
     end
   end
 end
