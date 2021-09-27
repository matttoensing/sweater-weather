class Api::V1::BookSearchController < ApplicationController
  def index
    location = GeocodeFacade.create_location(params[:location])
    book_search = BookSearchFacade.create_book_search()
  end
end
