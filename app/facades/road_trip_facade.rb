class RoadTripFacade
  class << self
    def road_trip(start_city, end_city)
      data = {
        start_city: start_city,
        end_city: end_city,
        travel_time: find_travel_time(start_city, end_city),
        weather_at_eta: weather_at_eta(start_city, end_city)
      }
      RoadTrip.new(data)
    end

    def weather_at_eta(start_city, end_city)
      coordinates = find_lat_and_long(end_city)
      time = ((find_travel_time(start_city, end_city).to_f / 60) / 60).round
      weather = OpenWeatherService.find_future_forecast(coordinates, time)
      RoadTripForecast.new(weather)
    end

    def find_travel_time(start_city, end_city)
      time = MapQuestGeocodingService.road_trip(start_city, end_city)
      time[:route][:legs][0][:time]
    end

    def find_lat_and_long(location)
      geocode = MapQuestGeocodingService.search(location)
      geocode[:results][0][:locations][0][:latLng]
    end
  end
end
