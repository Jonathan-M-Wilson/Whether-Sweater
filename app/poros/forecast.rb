class Forecast
  attr_reader :current_forecast,
              :hourly_forecast,
              :daily_forecast,
              :location

  def initialize(forecast_data, location)
    @location = location
    @current_forecast = forecast_data[:current]
    @hourly_forecast = forecast_data[:hourly]
    @daily_forecast = forecast_data[:daily]
  end
end
