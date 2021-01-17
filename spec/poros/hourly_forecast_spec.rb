require 'rails_helper'

RSpec.describe HourlyForecast do
  it "can create a HourlyForecast" do

    data = {
      :time=>1610917200,
      :temperature=>46.87,
      :wind_speed=>2.24,
      :wind_direction=>174,
      :conditions=>"broken clouds",
      :icon=>"04d"
    }

    hourly_forecast = HourlyForecast.new(data)

    expect(hourly_forecast.time).to be_a(String)
    expect(hourly_forecast.icon).to be_a(String)
    expect(hourly_forecast.temperature).to be_a(Float)
    expect(hourly_forecast.wind_speed).to be_a(String)
    expect(hourly_forecast.conditions).to be_a(String)
    expect(hourly_forecast.wind_direction).to be_a(String)
  end
end
