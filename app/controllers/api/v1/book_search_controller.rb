class Api::V1::BookSearchController < ApplicationController
  def index
    location = GeocodeFacade.create_location(params[:location])
    book_search = BookSearchFacade.create_book_search(params[:location], params[:quantity], location.latitude, location.longitude)
    json_response(BooksSerializer.new(book_search))
  end
end
