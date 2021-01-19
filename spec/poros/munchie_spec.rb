require 'rails_helper'

RSpec.describe Munchie do
  it "can create a munchie poro with attributes" do

    data = {
      destination_city: "Denver,Co",
      travel_time: 6097,
      forecast: {
      summary: "overcast clouds",
      temperature: 33.84},
      restaurant: {
      address: "1935 Federal Blvd, Denver, CO 80204",
      name: "Taste of China"}
    }

    data_2 = {
      destination_city: "Denver,Co",
      travel_time: 10860,
      forecast: {
      summary: "overcast clouds",
      temperature: 33.84},
      restaurant: {
      address: "1935 Federal Blvd, Denver, CO 80204",
      name: "Taste of China"}
    }

    munchie = Munchie.new(data)
    munchie_2 = Munchie.new(data_2)

    expect(munchie.travel_time).to be_a(String)
    expect(munchie.destination_city).to eq(data[:destination_city])
    expect(munchie.forecast.size).to eq(2)
    expect(munchie.restaurant.size).to eq(2)

    expect(munchie_2.travel_time).to be_a(String)
  end
end
