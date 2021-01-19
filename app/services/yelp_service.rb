class YelpService
  class << self
    def get_buisnesses(destination_city, unix_time)
      response = conn.get "v3/businesses/search" do |req|
        req.params['location'] = destination_city
        req.params['open_at'] = unix_time
      end
      get_json(response)
    end

    private

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: 'https://api.yelp.com/') do |f|
      f.headers['Authorization'] = ENV['Yelp_API_KEY']
      end
    end
  end
end
