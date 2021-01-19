require 'rails_helper'

RSpec.describe RoadTrip do
  it "can create a road trip with a formatted travel time" do

    params = {
      :start_city=>"Denver,CO",
      :end_city=>"Pueblo,CO",
      :travel_time=>6262,
      :weather_at_eta=>
      {
        :conditions=>"light rain",
        :temperature=> 38.93
      }
    }

    params_2 = {
      :start_city=>"Denver,CO",
      :end_city=>"Pueblo,CO",
      :travel_time=>10860,
      :weather_at_eta=>
      {
        :conditions=>"light rain",
        :temperature=> 38.93
      }
    }

    road_trip = RoadTrip.new(params)

    expect(road_trip.start_city).to eq(params[:start_city])
    expect(road_trip.end_city).to eq(params[:end_city])
    expect(road_trip.travel_time).to be_a(String)
    expect(road_trip.weather_at_eta).to be_a(Hash)
    expect(road_trip.weather_at_eta[:conditions]).to be_a(String)
    expect(road_trip.weather_at_eta[:temperature]).to be_a(Float)

    road_trip_2 = RoadTrip.new(params_2)
    expect(road_trip_2.formatted_travel_time(params_2[:travel_time])).to be_a(String)
  end
end
