require 'rails_helper'

RSpec.describe DailyWeather do
  before(:each) do
    @attributes = {
      dt: 1_632_510_000,
      sunrise: 1_632_489_985,
      sunset: 1_632_533_450,
      moonrise: 1_632_541_440,
      moonset: 1_632_502_260,
      moon_phase: 0.62,
      temp: {
        day: 306.67,
        min: 299.01,
        max: 308.13,
        night: 301.87,
        eve: 307.24,
        morn: 299.08
      },
      feels_like: {
        day: 305.11,
        night: 301.24,
        eve: 305.52,
        morn: 298.98
      },
      pressure: 1012,
      humidity: 25,
      dew_point: 284.03,
      wind_speed: 5.32,
      wind_deg: 220,
      wind_gust: 7.01,
      weather: [
        {
          id: 802,
          main: 'Clouds',
          description: 'scattered clouds',
          icon: '03d'
        }
      ],
      clouds: 26,
      pop: 0.19,
      uvi: 6.55
    }

    @daily_weather = DailyWeather.new(@attributes)
  end

  it 'exists and has attributes' do
    expect(@daily_weather).to be_an_instance_of(DailyWeather)
    expect(@daily_weather.date).to eq(Time.at(@attributes[:dt]).strftime('%F'))
    expect(@daily_weather.sunrise).to eq(Time.at(@attributes[:sunrise]).to_s)
    expect(@daily_weather.sunset).to eq(Time.at(@attributes[:sunset]).to_s)
    expect(@daily_weather.max_temp).to eq(@attributes[:temp][:max])
    expect(@daily_weather.min_temp).to eq(@attributes[:temp][:min])
    expect(@daily_weather.conditions).to eq(@attributes[:weather][0][:description])
    expect(@daily_weather.icon).to eq('http://openweathermap.org/img/w/03d.png')
  end

  it 'can format an icon to the correct url' do
    expected = 'http://openweathermap.org/img/w/03d.png'
    expect(@daily_weather.format_icon('03d')).to eq(expected)
  end

  it 'can format time correctly' do
    expected = Time.at(@attributes[:sunrise])
    expect(@daily_weather.format_time(1_632_489_985)).to eq(expected)
  end
end
