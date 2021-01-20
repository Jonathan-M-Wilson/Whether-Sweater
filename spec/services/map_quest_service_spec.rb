require 'rails_helper'

RSpec.describe 'Map Quest Geocoding Service' do
  it "can retrieve coordinates for a location" do
    VCR.use_cassette('/services/retrieve_coordinates_for_location') do

      location = "Denver,Co"

      geocode = MapQuestGeocodingService.search(location)
      coordinates = geocode[:results][0][:locations][0][:latLng]

      expect(coordinates).to be_a(Hash)
      expect(coordinates.size).to eq(2)
      expect(coordinates[:lat]).to be_an(Float)
      expect(coordinates[:lng]).to be_an(Float)
    end
  end

  it "can retrieve directions for a roadtrip along with a travel time" do
    VCR.use_cassette('/services/retrieve_directions_for_roadtrip') do

      start_city = "Denver,Co"
      end_city = "Pueblo,Co"

      directions = MapQuestGeocodingService.road_trip(start_city, end_city)
      time = directions[:route][:legs][0][:time]

      expect(time).to be_an(Integer)
      expect(directions).to be_a(Hash)
    end
  end
end
