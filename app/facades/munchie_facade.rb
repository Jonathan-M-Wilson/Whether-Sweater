class MunchieFacade
  class << self
    def munchie(start_city, end_city, food)
      unix_time = 1610955000

      data = {
        destination_city: end_city,
        travel_time: find_travel_time(start_city, end_city),
        forecast: current_forecast_at_destination(end_city),
        restaurant: restaurant_at_destination(end_city, unix_time, food)
      }
      require "pry"; binding.pry
      RoadTrip.new(data)
    end

    def current_forecast_at_destination(end_city)
      coordinates = find_lat_and_long(end_city)
      weather = OpenWeatherService.forecast_by_coordinates(coordinates)
      MunchieForecast.new(weather[:current])
    end

    def find_travel_time(start_city, end_city)
      time = MapQuestGeocodingService.road_trip(start_city, end_city)
      time[:route][:legs][0][:time]
    end

    def find_lat_and_long(location)
      geocode = MapQuestGeocodingService.search(location)
      geocode[:results][0][:locations][0][:latLng]
    end

    def restaurant_at_destination(end_city, unix_time, food)
      resaurant = YelpService.get_businesses(end_city, unix_time, food)
      data = resaurant[:businesses][0]
      Restaurant.new(data)
    end
  end
end
