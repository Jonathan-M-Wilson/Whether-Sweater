require 'rails_helper'

RSpec.describe 'Open Weather Service' do
  it "can retrieve a forecast by coordinates" do
    VCR.use_cassette('/services/retrieve_forecast_by_coordinates') do

      location = "Denver,Co"

      geocode = MapQuestGeocodingService.search(location)
      coordinates = geocode[:results][0][:locations][0][:latLng]

      weather = OpenWeatherService.forecast_by_coordinates(coordinates)

      current_weather = weather[:current]
      daily_weather = weather[:daily][1..5]
      hourly_weather = weather[:hourly][1..8]

      expect(current_weather).to be_a(Hash)
      expect(current_weather.size).to eq(15)
      expect(current_weather[:weather]).to be_an(Array)

      expect(daily_weather.size).to eq(5)
      expect(daily_weather).to be_an(Array)

      expect(hourly_weather.size).to eq(8)
      expect(hourly_weather).to be_an(Array)
    end
  end

  it "can find_future_forecast" do
    VCR.use_cassette('/services/retrieve_future_forecast') do

      location = "Denver,Co"

      geocode = MapQuestGeocodingService.search(location)
      coordinates = geocode[:results][0][:locations][0][:latLng]

      start_city = "Denver,Co"
      end_city = "Pueblo,Co"

      travel_time = RoadTripFacade.find_travel_time(start_city, end_city)
      time = ((travel_time.to_f / 60) / 60).round

      weather = OpenWeatherService.find_future_forecast(coordinates, time)

      expect(weather).to be_a(Hash)
      expect(weather.size).to eq(2)
      expect(weather[:temp]).to be_a(Float)
      expect(weather[:description]).to be_a(String)
      expect(weather.keys).to eq([:temp, :description])
    end
  end
end
