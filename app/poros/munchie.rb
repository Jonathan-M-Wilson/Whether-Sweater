class Munchie
  attr_reader :destination_city,
              :travel_time,
              :forecast,
              :restaurant

  def initialize(data)
    @destination_city = data[:destination_city]
    @travel_time = formatted_travel_time(data[:travel_time])
    @forecast = data[:forecast]
    @restaurant = data[:restaurant]
  end

  def formatted_travel_time(data)
    minutes = data.to_f / 60
    hours = (minutes / 60).to_i
    fractal_hours = (minutes / 60).round(2).modulo(1)
    fractal_minutes = (fractal_hours * 60).round

    pluralize_hours =
      if hours == 1
        "hour"
      else
        "hours"
      end

    pluralize_minutes =
      if fractal_minutes == 1
        "minute"
      else
        "minutes"
      end

    "#{hours} #{pluralize_hours}, #{fractal_minutes} #{pluralize_minutes}"
  end
end
