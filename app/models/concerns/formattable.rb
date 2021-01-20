module Formattable
  def format_time(time)
    Time.zone.at(time)
  end

  def format_strftime_time(time, format)
    Time.zone.at(time).strftime(format)
  end

  def icon_link(icon_code)
    "http://openweathermap.org/img/wn/#{icon_code}@2x.png"
  end
end
