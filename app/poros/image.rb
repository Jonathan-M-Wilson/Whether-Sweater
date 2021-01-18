class Image
  attr_reader :image

  def initialize(data)
    @image = {
      location: data[:location],
      image_url: data[:image_url],
      credit:  data[:credit]
    }
  end
end
