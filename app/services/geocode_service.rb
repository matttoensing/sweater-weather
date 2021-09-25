class GeocodeService < BaseService
  def self.get_location_info(city)
    response = conn('http://www.mapquestapi.com/geocoding/v1/address').get do |f|
      f.params['key'] = ENV['geo_key']
      f.params['location'] = city
    end
    get_json(response)
  end
end
