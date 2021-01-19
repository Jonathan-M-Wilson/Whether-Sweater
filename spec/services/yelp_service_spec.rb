require 'rails_helper'

RSpec.describe 'Yelp Service' do
  it "can retrieve name and address of a restaurant in your end location that is open" do
    VCR.use_cassette('/yelp_service/can_retrieve_restaurant_data') do
      end_city = 'Denver,Co'
      unix_time = 1610955000
      food = 'chinese'

      restaurant_data = YelpService.get_businesses(end_city, unix_time, food)
      first_resaurant = restaurant_data[:businesses][0]

      expect(first_resaurant[:name]).to be_a(String)
      expect(first_resaurant[:is_closed]).to eq(false)
      expect(first_resaurant[:location][:display_address]).to be_an(Array)
    end
  end
end
