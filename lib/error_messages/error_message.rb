class ErrorMessage
  def self.forecast_location_not_included_error
    {
      "message": "Location must be present",
      "error": "bad request"
    }
  end
end
