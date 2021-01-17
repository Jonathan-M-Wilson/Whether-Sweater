class OpenWeatherService
  class << self
    def forecast_by_coordinates(coordinates)
      longitude = coordinates[:lng]
      latitude = coordinates[:lat]
      get_json("/data/2.5/onecall?lat=#{latitude}&lon=#{longitude}")
    end

    private

    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: ENV['OPEN_WEATHER_SERVICE_URL']) do |f|
        f.params['units'] = 'imperial'
        f.params[:appid] = ENV['OPEN_WEATHER_API_KEY']
      end
    end
  end
end
