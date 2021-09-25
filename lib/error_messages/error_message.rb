class ErrorMessage
  def self.location_not_included_error
    {
      "message": "Location must be present",
      "error": "bad request"
    }
  end

  def self.no_location_error
    {
      "message": "Location could not be found",
      "error": "bad request"
    }
  end

  def self.bad_credentials_for_user
    {
      "message": "user credentials are invalid",
      "error": "bad request"
    }
  end
end
