require 'rails_helper'

RSpec.describe MunchieFacade do
  it "can create munchie objects with attributes" do
    #VCR.use_cassette('/munchie_facade/pueblo_munchie.json') do

    start_city = 'Pueblo,Co'
    end_city = 'Denver,Co'
    food = 'chinese'


      munchie = MunchieFacade.munchie(start_city, end_city, food)

      require "pry"; binding.pry
      expect(image).to be_an_instance_of(Image)

      expect(image.image[:credit]).to be_a(Hash)
      expect(image.image[:location]).to be_a(String)
      expect(image.image[:location]).to eq(location)
      expect(image.image[:image_url]).to be_a(String)
    end
  end
