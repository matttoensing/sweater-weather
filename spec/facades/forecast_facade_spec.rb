require 'rails_helper'

RSpec.describe ForecastFacade do
  # it 'can create current weather conditions', :vcr do
  #   expected = {
  #     datetime: "2021-09-26 17:03:01 -0700",
  #     conditions: "overcast clouds",
  #     temperature: 86.4,
  #     humidity: 41,
  #     feels_like: 86.1,
  #     uvi: 0.71,
  #     visibility: 10_000,
  #     sunrise: "2021-09-26 06:27:49 -0700",
  #     sunset: "2021-09-26 18:27:59 -0700"
  #   }
  #   weather = ForecastFacade.current_weather('34.28088', '-114.18384')
  #
  #   expect(weather).to eq(expected)
  # end
  #
  # it 'can create hourly weather conditions', :vcr do
  #   expected = {
  #     time: "18:00:00",
  #     conditions: "overcast clouds",
  #     temperature: 85.3,
  #     icon: "http://openweathermap.org/img/w/04d.png"
  #   }
  #
  #   hourly_weather = ForecastFacade.hourly_weather('34.28088', '-114.18384')
  #
  #   expect(hourly_weather.class).to eq(Array)
  #   expect(hourly_weather.count).to eq(8)
  #   expect(hourly_weather[0]).to eq(expected)
  # end
  #
  # it 'can create daily weather conditions', :vcr do
  #   expected = {
  #     date: "2021-09-27",
  #     conditions: "clear sky",
  #     max_temp: 89.3,
  #     min_temp: 73.0,
  #     sunrise: "2021-09-27 06:28:32 -0700",
  #     sunset: "2021-09-27 18:26:35 -0700",
  #     icon: "http://openweathermap.org/img/w/01d.png"
  #   }
  #
  #   daily_weather = ForecastFacade.daily_weather('34.28088', '-114.18384')
  #
  #   expect(daily_weather.class).to eq(Array)
  #   expect(daily_weather.count).to eq(5)
  #   expect(daily_weather[0]).to eq(expected)
  # end
  #
  # it 'can create weather information using previously defined class methods', :vcr do
  #   current = {
  #     datetime: "2021-09-26 17:29:57 -0700",
  #     conditions: "overcast clouds",
  #     temperature: 85.8,
  #     humidity: 41,
  #     feels_like: 85.4,
  #     uvi: 0.71,
  #     visibility: 10_000,
  #     sunrise: "2021-09-26 06:27:49 -0700",
  #     sunset: "2021-09-26 18:27:59 -0700"
  #   }
  #
  #   hourly = {
  #     conditions: "overcast clouds",
  #     icon: "http://openweathermap.org/img/w/04d.png",
  #     temperature: 84.97,
  #     time: "18:00:00",
  #   }
  #
  #   daily = {
  #     date: "2021-09-27",
  #     conditions: "clear sky",
  #     max_temp: 89.3,
  #     min_temp: 73.0,
  #     sunrise: "2021-09-27 06:28:32 -0700",
  #     sunset: "2021-09-27 18:26:35 -0700",
  #     icon: "http://openweathermap.org/img/w/01d.png"
  #   }
  #
  #   weather = ForecastFacade.weather_data('34.28088', '-114.18384')
  #
  #   expect(weather[:current_weather]).to eq(current)
  #   expect(weather[:daily_weather][0]).to eq(daily)
  #   expect(weather[:hourly_weather][0]).to eq(hourly)
  # end

  it 'can create weather objects', :vcr do
    weather = ForecastFacade.create_weather('34.28088', '-114.18384')

    expect(weather).to be_an_instance_of(Forecast)
  end
end
