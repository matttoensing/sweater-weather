require 'rails_helper'

RSpec.describe ForecastFacade do
  it 'can create weather objects with default unit argument', :vcr do
    weather = ForecastFacade.create_weather('34.28088', '-114.18384')

    expect(weather).to be_an_instance_of(Forecast)
    expect(weather.current_weather).to be_an_instance_of(CurrentWeather)

    weather.daily_weather.each do |daily|
      expect(daily).to be_an_instance_of(DailyWeather)
    end

    weather.hourly_weather.each do |hourly|
      expect(hourly).to be_an_instance_of(HourlyWeather)
    end
  end

  it 'can create weather objects with a metric units argument', :vcr do
    weather = ForecastFacade.create_weather('34.28088', '-114.18384', 'metric')

    expect(weather).to be_an_instance_of(Forecast)
    expect(weather.current_weather.temperature).to eq(30.9)
  end
end
