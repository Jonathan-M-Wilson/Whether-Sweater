class CurrentForecast
  include Formattable

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
    @datetime = format_time(current_forecast_params[:datetime]).to_s
    @sunrise = format_time(current_forecast_params[:sunrise]).to_s
    @sunset = format_time(current_forecast_params[:sunset]).to_s
    @temperature = current_forecast_params[:temperature]
    @feels_like = current_forecast_params[:feels_like]
    @humidity = current_forecast_params[:humidity]
    @uvi = current_forecast_params[:uvi]
    @visibility = current_forecast_params[:visibility]
    @conditions = current_forecast_params[:conditions]
    @icon = icon_link(current_forecast_params[:icon])
  end
end
