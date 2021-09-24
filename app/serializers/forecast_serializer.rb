class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :current_weather do |object|
    object.current_weather
  end

  attributes :daily_weather do |object|
    object.daily_weather
  end

  attributes :hourly_weather do |object|
    object.hourly_weather
  end
end
