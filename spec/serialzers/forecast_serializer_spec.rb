require 'rails_helper'

RSpec.describe ForecastSerializer do
  it "can serialize a forecast" do
    location = 'denver,co'

    current_weather_data = {
      :datetime=>1610915666,
      :sunrise=>1610893087,
      :sunset=>1610928108,
      :temperature=>47.77,
      :feels_like=>41.88,
      :humidity=>28,
      :uvi=>1.13,
      :visibility=>10000,
      :conditions=>"overcast clouds",
      :icon=>"04d"
    }

    daily_weather_data = {
      :date=>1610996400,
      :sunrise=>1610979458,
      :sunset=>1611014575,
      :max_temp=>41.85,
      :min_temp=>29.14,
      :conditions=>"clear sky",
      :icon=>"01d"
    }

    hourly_weather_data = {
      :time=>1610917200,
      :temperature=>46.87,
      :wind_speed=>2.24,
      :wind_direction=>174,
      :conditions=>"broken clouds",
      :icon=>"04d"
    }

    hourly_weather = HourlyForecast.new(hourly_weather_data)
    daily_weather = DailyForecast.new(daily_weather_data)
    current_weather = CurrentForecast.new(current_weather_data)


    data = {
      current_weather: current_weather,
      daily_weather: daily_weather,
      hourly_weather: hourly_weather
    }

    forecast = Forecast.new(data, location)

    serialized = ForecastSerializer.new(forecast).serializable_hash

    expect(serialized).to have_key(:data)
    expect(serialized[:data].size).to eq(3)
    expect(serialized[:data]).to have_key(:id)
    expect(serialized[:data]).to have_key(:type)
    expect(serialized[:data][:type]).to eq(:forecast)
    expect(serialized[:data]).to have_key(:attributes)
    expect(serialized[:data][:attributes]).to have_key(:location)
    expect(serialized[:data][:attributes]).to have_key(:current_weather)
    expect(serialized[:data][:attributes]).to have_key(:daily_weather)
    expect(serialized[:data][:attributes]).to have_key(:hourly_weather)
  end
end
