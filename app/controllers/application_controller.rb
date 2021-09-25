class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  after_action :set_code_on_create, only: [:create]

  private

  def set_code_on_create
    response.status = 201 if response.status == 200
  end

  def req
    json = request.body.read
    return nil if json.empty?

    json_request(json)
  end
end
