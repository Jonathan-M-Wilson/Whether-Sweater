class OpenWeatherService
  class << self
    def forecast_by_coordinates(coordinates)
      longitude = coordinates[:lng]
      latitude = coordinates[:lat]

      response = conn.get '/data/2.5/onecall' do |req|
        req.params[:lat] = latitude
        req.params[:lon] = longitude
      end
      get_json(response)
    end

    def find_future_forecast(coordinates, time)
      longitude = coordinates[:lng]
      latitude = coordinates[:lat]

      response = conn.get '/data/2.5/onecall' do |req|
        req.params[:lat] = latitude
        req.params[:lon] = longitude
      end
      parsed_data = get_json(response)
      {
        temp: parsed_data[:hourly][time][:temp],
        description: parsed_data[:hourly][time][:weather][0][:description]
      }
    end

    private

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: 'https://api.openweathermap.org') do |f|
        f.params['units'] = 'imperial'
        f.params[:appid] = ENV['OPEN_WEATHER_API_KEY']
      end
    end
  end
end
