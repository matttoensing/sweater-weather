class Api::V1::BackgroundsController < ApplicationController
  def index
    if params[:location]
    image = ImageFacade.create_image(params[:location])
    json_response(ImageSerializer.new(image))
  else
    json_response(ErrorMessage.location_not_included_error, :bad_request)
  end
  end
end
