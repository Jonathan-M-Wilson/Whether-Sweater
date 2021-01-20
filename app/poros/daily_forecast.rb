class DailyForecast
  include Formattable

  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(daily_forecast_params)
    @date = format_strftime_time(daily_forecast_params[:date], '%F')
    @sunrise = format_strftime_time(daily_forecast_params[:sunrise], '%F %T%:z')
    @sunset = format_strftime_time(daily_forecast_params[:sunset], '%F %T%:z')
    @max_temp = daily_forecast_params[:max_temp]
    @min_temp = daily_forecast_params[:min_temp]
    @conditions = daily_forecast_params[:conditions]
    @icon = icon_link(daily_forecast_params[:icon])
  end
end
