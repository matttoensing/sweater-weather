class BookSearchFacade
  def self.create_book_search(book_data, query, quantity, lat, lon)
    forecast = WeatherService.get_weather_info(lat, lon)
    json = BookService.get_book_info(query, quantity)
    BookSearch.new(query, forecast, json)
  end
end
