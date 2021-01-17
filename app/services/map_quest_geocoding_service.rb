class MapQuestGeocodingService
  class << self
    def search(location)
      get_json("/geocoding/v1/address?location=#{location}")
    end

    private

    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: ENV['GEOCODE_SERVICE_URL']) do |f|
        f.params[:key] = ENV['MAPQUEST_CONSUMER_KEY']
      end
    end
  end
end
# ("/geocoding/v1/address?location=#{location}")
