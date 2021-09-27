class BookSearch
  attr_reader :destination,
              :forecast,
              :total_books_found,
              :books

  def initialize(location, weather_data, book_data)
    @destination = location
    @forecast = Weather.new(weather_data[:current])
    @total_books_found = book_data[:numFound]
    @books = create_books(book_data)
  end

  def create_books(data)
    data[:docs].map do |details|
      Book.new(details)
    end
  end
end
