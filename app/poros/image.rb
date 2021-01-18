class Image
  attr_reader :location,
              :image_url,
              :credit

  def initialize(data)
    @location = data[:location]
    @image_url = data[:image_url]
    @credit = data[:credit]
  end
end
