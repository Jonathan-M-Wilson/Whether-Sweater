class MapQuestGeocodingService
  class << self
    def search(location)
      response = conn.get '/geocoding/v1/address' do |req|
        req.params[:location] = location
      end
      get_json(response)
    end

    def road_trip(start_city, end_city)
      response = conn.get '/directions/v2/route' do |req|
        req.params[:from] = start_city
        req.params[:to] = end_city
      end
      get_json(response)
    end

    private

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: 'https://www.mapquestapi.com') do |f|
        f.params[:key] = ENV['MAPQUEST_CONSUMER_KEY']
      end
    end
  end
end
