class UnsplashService
  class << self
    def get_background(query)
      response = conn.get "/search/photos" do |req|
        req.params['query'] = query
        req.params['per_page'] = 1
        req.params['order_by'] = 'relevent'
      end
      get_json(response)[:results][0]
    end

    private

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: 'https://api.unsplash.com/') do |f|
      f.headers['Accept-Version'] = 'v1'
      f.params['client_id'] = ENV['UNSPLASH_API_KEY']
      end
    end
  end
end
