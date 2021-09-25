module Response
  def json_response(object, status = :ok)
    render(json: object, status: status)
  end

  def json_request(request)
    JSON.parse(request, symbolize_names: true)
  end
end
