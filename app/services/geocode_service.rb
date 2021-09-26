class GeocodeService < BaseService
  def self.get_location_info(city)
    response = conn('http://www.mapquestapi.com').get('/geocoding/v1/address') do |f|
      f.params['key'] = ENV['geo_key']
      f.params['location'] = city
    end
    get_json(response)
  end

  def self.get_directions_info(from, to)
    response = conn('http://www.mapquestapi.com').get('/directions/v2/route') do |f|
      f.params['key'] = ENV['geo_key']
      f.params['from'] = from
      f.params['to'] = to
    end
    get_json(response)
  end
end
