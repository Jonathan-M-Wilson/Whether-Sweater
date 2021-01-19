require 'rails_helper'

RSpec.describe RoadTripFacade do
  it "can create a road trip", :vcr do
    VCR.use_cassette('/road_trip/denver_to_pueblo.json') do

      start_city = "Denver,Co"
      end_city =  "Pueblo,Co"

      road_trip = RoadTripFacade.road_trip(start_city, end_city)

      expect(road_trip).to be_an_instance_of(RoadTrip)
    end
  end
end
