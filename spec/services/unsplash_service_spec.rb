require 'rails_helper'

RSpec.describe 'Unsplash Service' do
  it "can retrieve photo data for background" do
    VCR.use_cassette('/services/retrieve_photo_for_background') do

      location = "Denver,Co"
      photo = UnsplashService.get_background(location)
      photo_url = photo[:urls][:raw]

      expect(photo).to be_a(Hash)
      expect(photo_url).to be_a(String)
    end
  end
end
