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
      "message": "email or password is invalid",
      "error": "bad request"
    }
  end

  def self.roadtrip_info_missing
    {
      "message": "must include origin and destination",
      "error": "bad request"
    }
  end
end
