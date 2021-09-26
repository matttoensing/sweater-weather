class RoadtripFacade
  def self.starting_location(from, to)
    directions = GeocodeService.get_directions_info(from, to)
    directions[:route][:locations][0][:adminArea5] + ', ' + directions[:route][:locations][0][:adminArea3]
  end

  def self.ending_location(from, to)
    directions = GeocodeService.get_directions_info(from, to)
    directions[:route][:locations][1][:adminArea5] + ', ' + directions[:route][:locations][1][:adminArea3]
  end

  def self.travel_time(from, to)
    directions = GeocodeService.get_directions_info(from, to)
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

  def self.destination_weather(from, to)
    location = destination_location(to)
    json = WeatherService.get_weather_info(location.latitude, location.longitude)
    DestinationWeather.new(json, travel_time(from, to))
  end

  def self.create_destination_info(from, to)
    {
      start_city: starting_location(from, to),
      end_city: ending_location(from, to),
      travel_time: format_travel_time(from, to),
      weather_at_eta: {
        temperature: destination_weather(from, to).temperature,
        conditions: destination_weather(from, to).conditions
      }
    }
  end

  def self.create_roadtrip(from, to)
    json = GeocodeService.get_directions_info(from, to)
    Roadtrip.new(create_destination_info(from, to))
  end
end
