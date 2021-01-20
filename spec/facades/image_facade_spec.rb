require 'rails_helper'

RSpec.describe ImageFacade do
  it "can create an image with a location", :vcr do
    VCR.use_cassette('/facade/denver_image.json') do

      location = 'Denver City Colorado'
      image = ImageFacade.get_background(location)
      expect(image).to be_an_instance_of(Image)

      expect(image.image[:credit]).to be_a(Hash)
      expect(image.image[:location]).to be_a(String)
      expect(image.image[:location]).to eq(location)
      expect(image.image[:image_url]).to be_a(String)
    end
  end
end
