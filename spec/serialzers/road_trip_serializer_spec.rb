require 'rails_helper'

RSpec.describe RoadTripSerializer do

  it "can serialize a roadtrip" do
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

    road_trip = RoadTrip.new(params)
    road_trip_json = RoadTripSerializer.new(road_trip).serializable_hash

    expect(road_trip_json).to have_key(:data)
    expect(road_trip_json[:data]).to have_key(:id)
    expect(road_trip_json[:data]).to have_key(:type)
    expect(road_trip_json[:data]).to have_key(:attributes)
    expect(road_trip_json[:data][:attributes].size).to eq(4)
    expect(road_trip_json[:data][:attributes]).to have_key(:start_city)
    expect(road_trip_json[:data][:attributes]).to have_key(:end_city)
    expect(road_trip_json[:data][:attributes]).to have_key(:travel_time)
    expect(road_trip_json[:data][:attributes]).to have_key(:weather_at_eta)
  end
end
