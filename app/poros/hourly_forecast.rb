class HourlyForecast
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon

  def initialize(hourly_forecast_params)
    @time = format_time(hourly_forecast_params[:time], '%T')
    @temperature = hourly_forecast_params[:temperature]
    @wind_speed = hourly_forecast_params[:wind_speed]
    @wind_direction = hourly_forecast_params[:wind_direction]
    @conditions = hourly_forecast_params[:conditions]
    @icon = icon_link(hourly_forecast_params[:icon])
  end

  def format_time(time, format)
    Time.at(time).strftime(format)
  end

  def icon_link(icon_code)
    "http://openweathermap.org/img/wn/#{icon_code}@2x.png"
  end
end
