class ForecastFacade
  class << self
    def weather(location)
      data = {
        current_weather: current_weather(location),
        daily_weather: daily_weather(location),
        hourly_weather: hourly_weather(location)
      }
      Forecast.new(data, location)
    end

    def current_weather(location)
      coordinates = find_lat_and_long(location)
      data = {
        datetime: weather_service(coordinates)[:current][:dt],
        sunrise: weather_service(coordinates)[:current][:sunrise],
        sunset: weather_service(coordinates)[:current][:sunset],
        temperature: weather_service(coordinates)[:current][:temp],
        feels_like: weather_service(coordinates)[:current][:feels_like],
        humidity: weather_service(coordinates)[:current][:humidity],
        uvi: weather_service(coordinates)[:current][:uvi],
        visibility: weather_service(coordinates)[:current][:visibility],
        conditions: weather_service(coordinates)[:current][:weather][0][:description],
        icon: weather_service(coordinates)[:current][:weather][0][:icon]
      }
      CurrentForecast.new(data)
    end

    def daily_weather(location)
      coordinates = find_lat_and_long(location)
      weather_service(coordinates)[:daily][1..5].map do |forecast|
        data = {
          date: forecast[:dt],
          sunrise: forecast[:sunrise],
          sunset: forecast[:sunset],
          max_temp: forecast[:temp][:max],
          min_temp: forecast[:temp][:min],
          conditions: forecast[:weather][0][:description],
          icon: forecast[:weather][0][:icon]
        }
        DailyForecast.new(data)
      end
    end

    def hourly_weather(location)
      coordinates = find_lat_and_long(location)
      weather_service(coordinates)[:hourly][1..8].map do |forecast|
        data = {
          time: forecast[:dt],
          temperature: forecast[:temp],
          wind_speed: forecast[:wind_speed],
          wind_direction: forecast[:wind_deg],
          conditions: forecast[:weather][0][:description],
          icon: forecast[:weather][0][:icon]
        }
        HourlyForecast.new(data)
      end
    end

    def find_lat_and_long(location)
      geocode = geocode_service(location)
      geocode[:results][0][:locations][0][:latLng]
    end

    def weather_service(coordinates)
      OpenWeatherService.forecast_by_coordinates(coordinates)
    end

    def geocode_service(location)
      MapQuestGeocodingService.search(location)
    end
  end
end
