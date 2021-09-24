class GeocodeFacade
  def self.create_location(location)
    json = GeocodeService.get_location_info(location)
    Location.new(json)
  end
end
