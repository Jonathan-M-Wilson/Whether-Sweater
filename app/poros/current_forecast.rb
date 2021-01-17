class CurrentForecast
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(current_forecast_params)
    @datetime = format_time(current_forecast_params[:datetime])
    @sunrise = format_time(current_forecast_params[:sunrise])
    @sunset = format_time(current_forecast_params[:sunset])
    @temperature = current_forecast_params[:temperature]
    @feels_like = current_forecast_params[:feels_like]
    @humidity = current_forecast_params[:humidity]
    @uvi = current_forecast_params[:uvi]
    @visibility = current_forecast_params[:visibility]
    @conditions = current_forecast_params[:conditions]
    @icon = icon_link(current_forecast_params[:icon])
  end

  def format_time(time)
    Time.at(time)
  end

  def icon_link(icon_code)
    "http://openweathermap.org/img/wn/#{icon_code}@2x.png"
  end
end