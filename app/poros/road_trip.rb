class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(data)
    @start_city = data[:start_city]
    @end_city = data[:end_city]
    @travel_time = formatted_travel_time(data[:travel_time])
    @weather_at_eta = format_weather(data)
  end

  def format_weather(data)
    if data[:travel_time] == 'impossible'
      nil
    else
      data[:weather_at_eta]
    end
  end

  def formatted_travel_time(data)
    if data == 'impossible'
      'impossible'
    else
      minutes = data.to_f / 60
      hours = (minutes / 60).to_i
      fractal_hours = (minutes / 60).round(2).modulo(1)
      fractal_minutes = (fractal_hours * 60).round

      pluralize_hours =
        if hours == 1
          'hour'
        else
          'hours'
        end

      pluralize_minutes =
        if fractal_minutes == 1
          'minute'
        else
          'minutes'
        end

      "#{hours} #{pluralize_hours}, #{fractal_minutes} #{pluralize_minutes}"
    end
  end
end
