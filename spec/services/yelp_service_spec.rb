require 'rails_helper'

RSpec.describe 'Yelp Service' do
  it "can retrieve name and address of a restaurant in your end location that is open", :vcr do
    VCR.use_cassette('/Yelp_Service/can_retrieve_restaurant_data') do
      end_city = 'Pueblo,Co'
      unix_time = 1610955000

      restaurant_data = YelpService.get_buisnesses(end_city, unix_time)

      first_resaurant = restaurant_data[:businesses][0]

      expect(first_resaurant[:name]).to be_a(String)
      expect(first_resaurant[:is_closed]).to eq(false)
      expect(first_resaurant[:location][:display_address]).to be_an(Array)
    end
  end
end
