require 'rails_helper'

 RSpec.describe BookSearch do
   it 'exists and has attributes' do
     location = 'denver,co'
     forecast = { current: {
      dt: 1632757257,
      sunrise: 1632749312,
      sunset: 1632792395,
      temp: 77.68,
      feels_like: 77.45,
      pressure: 1013,
      humidity: 49,
      dew_point: 57.02,
      uvi: 1.67,
      clouds: 32,
      visibility: 10000,
      wind_speed: 5.84,
      wind_deg: 144,
      wind_gust: 8.16,
      weather: [
          {
              id: 802,
              main: "Clouds",
              description: "scattered clouds",
              icon: "03d"}]}}
     response = File.read('spec/fixtures/book_response.json')

     book_data = JSON.parse(response, symbolize_names: true)

     book_search = BookSearch.new(location, forecast, book_data)

     expect(book_search).to be_an_instance_of(BookSearch)
     expect(book_search.destination).to eq(location)
     expect(book_search.total_books_found).to eq(book_data[:numFound])
     expect(book_search.forecast).to be_an_instance_of(Weather)
     expect(book_search.forecast.temperature).to eq(77.7)
     expect(book_search.forecast.summary).to eq("scattered clouds")
     book_search.books.each do |book|
       expect(book).to be_an_instance_of(Book)
     end
   end
 end
