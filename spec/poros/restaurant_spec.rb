require 'rails_helper'

RSpec.describe Restaurant do
  it "can create a restaurant with attributes" do

    data = {
      :name=>"New Century Karaoke & Restaurant",
      :location=>
      {
        :display_address=>["1555 S Havana St", "Unit B", "Denver, CO 80012"]
      }
    }

    restaurant = Restaurant.new(data)

    expect(restaurant.name).to eq(data[:name])
    expect(restaurant.address).to eq(data[:location][:display_address].join(', '))
  end
end
