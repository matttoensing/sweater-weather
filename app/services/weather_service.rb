class WeatherService < BaseService
  def self.get_weather_info(lat, lon, units = 'imperial')
    response = conn('http://api.openweathermap.org').get('/data/2.5/onecall') do |f|
      f.params['lat'] = lat
      f.params['lon'] = lon
      f.params['units'] = units
      f.params['appid'] = ENV['weather_key']
    end
    get_json(response)
  end
end
