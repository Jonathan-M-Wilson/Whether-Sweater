class HourlyForecast
  include Formattable
  
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon

  def initialize(hourly_forecast_params)
    @time = format_strftime_time(hourly_forecast_params[:time], '%T')
    @temperature = hourly_forecast_params[:temperature]
    @wind_speed = wind_speed_to_string(hourly_forecast_params)
    @wind_direction = wind_direction_degrees_to_compass(hourly_forecast_params)
    @conditions = hourly_forecast_params[:conditions]
    @icon = icon_link(hourly_forecast_params[:icon])
  end

  def wind_speed_to_string(hourly_forecast_params)
    wind_speed = hourly_forecast_params[:wind_speed]
    "#{wind_speed} mph"
  end

  def wind_direction_degrees_to_compass(hourly_forecast_params)
    degree = hourly_forecast_params[:wind_direction]

    compass_sector = %w[
      N
      NNE
      NE
      ENE
      E
      ESE
      SE
      SSE
      S
      SSW
      SW
      WSW
      W
      WNW
      NW
      NNW
      N
    ]

    compass_sector[(degree / 22.5)]
  end
end
