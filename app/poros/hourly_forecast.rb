class HourlyForecast
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(hourly_forecast_params)
    @time = format_time(hourly_forecast_params[:time], '%T')
    @temperature = hourly_forecast_params[:temperature]
    @wind_speed = wind_speed_to_string(hourly_forecast_params)
    @wind_direction = wind_direction_degrees_to_compass(hourly_forecast_params)
    @conditions = hourly_forecast_params[:conditions]
    @icon = icon_link(hourly_forecast_params[:icon])
  end

  def format_time(time, format)
    Time.at(time).strftime(format)
  end

  def icon_link(icon_code)
    "http://openweathermap.org/img/wn/#{icon_code}@2x.png"
  end

  def wind_speed_to_string(hourly_forecast_params)
    wind_speed = hourly_forecast_params[:wind_speed]
    "#{wind_speed} mph"
  end

  def wind_direction_degrees_to_compass(hourly_forecast_params)
    degree = hourly_forecast_params[:wind_direction]

    compass_sector = [
      "N",
      "NNE",
      "NE",
      "ENE",
      "E",
      "ESE",
      "SE",
      "SSE",
      "S",
      "SSW",
      "SW",
      "WSW",
      "W",
      "WNW",
      "NW",
      "NNW",
      "N"
      ]

    compass_sector[(degree / 22.5)]
  end
end
