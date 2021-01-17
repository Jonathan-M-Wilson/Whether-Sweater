class Forecast
  attr_reader :current_weather,
              :hourly_weather,
              :daily_weather,
              :location

  def initialize(forecast_data, location)
    @location = location
    @current_weather = forecast_data[:current_weather]
    @hourly_weather = forecast_data[:hourly_weather]
    @daily_weather = forecast_data[:daily_weather]
  end
end
