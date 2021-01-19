require 'rails_helper'

RSpec.describe RoadTripForecast do
  it "can create a forecast for a road trip" do
    data = {
      :temp=>38.88,
      :description=>"overcast clouds"
    }

    road_trip_forecast = RoadTripForecast.new(data)

    expect(road_trip_forecast.temperature).to eq(data[:temp])
    expect(road_trip_forecast.conditions).to eq(data[:description])
  end
end
