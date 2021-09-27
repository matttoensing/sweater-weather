class Api::V1::BookSearchController < ApplicationController
  def index
    if location_and_quantity_present?
      location = GeocodeFacade.create_location(params[:location])
      book_search = BookSearchFacade.create_book_search(params[:location], params[:quantity], location.latitude, location.longitude)
      json_response(BooksSerializer.new(book_search))
    else
      json_response(ErrorMessage.book_search_error, :bad_request)
    end
  end

  private

  def location_and_quantity_present?
    params[:quantity].present? && params[:location].present?
  end
end
