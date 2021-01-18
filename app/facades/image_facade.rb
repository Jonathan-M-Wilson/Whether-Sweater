class ImageFacade
  class << self
    def get_background(query)
      image = unsplash_service(query)
      data = {
        location: query,
        image_url: image[:urls][:raw],
        credit: credit(query)
      }
      Image.new(data)
    end

    private

    def credit(query)
      author = unsplash_service(query)
      {
        source: 'https://unsplash.com/',
        author: author[:user][:username],
        logo: 'https://unsplash.com/blog/content/images/max/2560/1-VnKoValwGK3-d1bZhD6sVA.jpeg'
      }
    end

    def unsplash_service(query)
      UnsplashService.get_background(query)
    end
  end
end
