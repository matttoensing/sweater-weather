class WeatherService < BaseService
  def self.get_weather_info(lat, lon)
    response = conn('http://api.openweathermap.org').get('/data/2.5/onecall') do |f|
      f.params['lat'] = lat
      f.params['lon'] = lon
      f.params['units'] = 'imperial'
      f.params['appid'] = ENV['weather_key']
    end
    get_json(response)
  end
end
