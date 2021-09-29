class RoadtripFacade
  def self.get_directions(from, to)
    GeocodeService.get_directions_info(from, to)
  end

  def self.get_weather(lat, lon)
    WeatherService.get_weather_info(lat, lon)
  end

  def self.starting_location(from, to)
    directions = get_directions(from, to)
    directions[:route][:locations][0][:adminArea5] + ', ' + directions[:route][:locations][0][:adminArea3]
  end

  def self.ending_location(from, to)
    directions = get_directions(from, to)
    directions[:route][:locations][1][:adminArea5] + ', ' + directions[:route][:locations][1][:adminArea3]
  end

  def self.travel_time(from, to)
    directions = get_directions(from, to)
    time = directions[:route][:formattedTime]
    time.split(':').map(&:to_i)
  end

  def self.format_travel_time(from, to)
    time = travel_time(from, to)
    hours, minutes, seconds = time
    "#{hours} Hours, #{minutes} Minutes"
  end

  def self.destination_location(to)
    json = GeocodeService.get_location_info(to)
    Location.new(json)
  end

  def self.destination_weather_temperature(from, to)
    location = destination_location(to)
    json = WeatherService.get_weather_info(location.latitude, location.longitude)
    time = travel_time(from, to)

    time[0] <= 47 ? hourly_weather_temperature(json, time) : daily_weather_temperature(json, time)
  end

  def self.destination_weather_conditions(from, to)
    location = destination_location(to)
    json = WeatherService.get_weather_info(location.latitude, location.longitude)
    time = travel_time(from, to)

    time[0] <= 47 ? hourly_weather_conditions(json, time) : daily_weather_conditions(json, time)
  end

  def self.hourly_weather_temperature(data, time)
    time[1] > 30 ? data[:hourly][time[0] + 1][:temp].round(1) : data[:hourly][time[0]][:temp].round(1)
  end

  def self.hourly_weather_conditions(data, time)
    time[1] > 30 ? data[:hourly][time[0] + 1][:weather][0][:description] : data[:hourly][time[0]][:weather][0][:description]
  end

  def self.daily_weather_temperature(data, time)
    daily_time = (time[0] / 24).round
    data[:daily][daily_time][:temp][:day].round(1)
  end

  def self.daily_weather_conditions(data, time)
    daily_time = (time[0] / 24).round
    data[:daily][daily_time][:weather][0][:description]
  end

  def self.create_destination_info(from, to)
    {
      start_city: starting_location(from, to),
      end_city: ending_location(from, to),
      travel_time: format_travel_time(from, to),
      weather_at_eta: {
        temperature: destination_weather_temperature(from, to),
        conditions: destination_weather_conditions(from, to)
      }
    }
  end

  def self.create_roadtrip(from, to)
    json = get_directions(from, to)
    json[:route][:routeError][:errorCode] == 2 ? nil : Roadtrip.new(create_destination_info(from, to))
  end
end
