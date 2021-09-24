class WeatherService < BaseService
  def self.get_weather_info(city)
    response = conn('http://api.weatherapi.com/v1/forecast.json').get do |f|
      f.params['key'] = ENV['weather_key']
      f.params['q'] = city
      f.params['days'] = '6'
    end
    get_json(response)
  end
 end
