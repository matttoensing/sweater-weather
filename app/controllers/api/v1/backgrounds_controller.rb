class Api::V1::BackgroundsController < ApplicationController
  def index
    image = ImageFacade.create_image(params[:location])
    json_response(ImageSerializer.new(image))
  end
end
